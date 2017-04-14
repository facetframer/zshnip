#!/usr/bin/env zsh
# snippets for expansion anywhere in the command line
# taken from http://zshwiki.org/home/examples/zleiab and expanded somewhat
#
# use: add-snippet <key> <expansion>
# then, with cursor just past <key>, run zshnip-expand

zshnip_should_log= # non-empty to log

snippets_file=~/.zshnip
#snippet_edit_func=snippet-editor-edit
zshnip_edit_func=zshnip-shell-edit

set -A _zshnip_defining # Stack of snippets that we are defining
set -A _zshnip_previous_lbuffer # Stack contents of zle buffer
set -A _zshnip_previous_rbuffer # Stack contents of zle buffer

typeset -Ag snippets

_zshnip-log() {
    if [ -n "${zshnip_should_log:-}" ]; then
        _zshnip-warn "$*"
    fi;
}

_zshnip-warn() {
    # Display a visible message
    echo >&2 "zshnip: $*"
}

_zshnip-log "Starting zshnip"

zshnip-add() {
    # zshnip-add <key> <expansion>
    snippets[$1]="$2"
}

zshnip-editor-edit() {
    name="$1"
    _zshnip-log "Editing $name"
    filename=$(mktemp)
    echo "$snippets[$snippet_match]" > "$filename"
    finished=$(mktemp --dry-run)
    tmux new-window bash -c "vim -c 'startinsert' $filename; touch $finished"

    # This can't handle a save and edit
    #   to support this we some sort of signal
    while [ ! -e "$finished" ]; do
        sleep 0.1;
    done;
    zshnip-write "$name" "$(cat $filename)"
}

zshnip-shell-edit() {
    emulate -L zsh
    setopt extendedglob
    _zshnip-log "Saving prompt: $PROMPT $LBUFFER ^ $RBUFFER"
    _zshnip_previous_lbuffer+=( "$LBUFFER" )
    _zshnip_previous_rbuffer+=( "$RBUFFER" )
    _zshnip_previous_prompt+=( "$PROMPT" )
    _zshnip_defining+=( "$1" )

    _zshnip-log "Editing $snippet_match"
    BUFFER="$snippets[$1]"
    PROMPT="$PROMPT DEFINING SNIPPET: $1 > "
    zle reset-prompt
    zle -A accept-line _zshnip_old_accept_line # Save previous accept line function
    zle -N accept-line _zshnip-shell-edit-accept-line
}
zle -N zshnip-shell-edit

_zshnip-shell-edit-accept-line() {
    _zshnip-log "Editing finished"
    emulate -L zsh
    local new_snippet defining previous_lbuffer previous_rbuffer

    zshnip-source
    previous_lbuffer=$_zshnip_previous_lbuffer[-1]
    previous_rbuffer=$_zshnip_previous_rbuffer[-1]
    previous_prompt=$_zshnip_previous_prompt[-1]
    defined=$_zshnip_defining[-1]

    zshnip-write "$defined" "$BUFFER"

    LBUFFER="$previous_lbuffer"
    RBUFFER="$previous_rbuffer"
    PROMPT="$previous_prompt"
    _zshnip-log "Restored prompt: $PROMPT ${LBUFFER}_${RBUFFER}"

    _zshnip_previous_lbuffer[-1]=()
    _zshnip_previous_rbuffer[-1]=()
    _zshnip_previous_prompt[-1]=()
    _zshnip_defining[-1]=()

    zle reset-prompt

    _zshnip-edit-finished-callback "$defined"

    if [[ "0" == "${#_zshnip_defining}" ]]; then

        zle -A _zshnip_old_accept_line accept-line
        _zshnip-log "Restoring accept-line: ${widgets[accept-line]}"
    fi;
}
zle -N zshnip-shell-finished

zshnip-source () {
    # Reload the snippets file
    if [ -f "$snippets_file" ]; then
        source "$snippets_file"
    fi;
}

zshnip-write () {
    # Save a snippet to permanent storage
    name=$1
    content=$2

    _zshnip-log "Saving snippet '$name' -> '$content'"

    escaped_content=$(echo "$content" | sed "s/'/\\\\'/g" )
    echo zshnip-add "$name" $'$\''"$escaped_content""'" >> $snippets_file
}

zshnip-expand() {
    emulate -L zsh
    setopt extendedglob
    _zshnip-parse-snippet
    LBUFFER=$snippet_new_lbuffer
    LBUFFER+="${snippets[$snippet_match]:-$snippet_match}"
}
zle -N zshnip-expand

_zshnip-edit() {
    local editor snippet
    editor=$1
    snippet=$2
    _zshnip_defining+=( $snippet )
    $zshnip_edit_func $editor _zshnip-edit-finished-callback
}

zshnip-expand-or-edit() {
    if [ -z "$BUFFER" ]; then
        # Useful binding to re-edit the last snippet if it was not right
        _zshnip-edit "$_zshnip_last_expanded"
        return
    fi;

    _zshnip-parse-snippet
    if [ -z "${snippets[$snippet_match]:-}" ]; then
        _zshnip-edit "$snippet_match"
    else
        _zshnip-expand "$snippet_match"
    fi;

}
zle -N zshnip-expand-or-edit

zshnip-save-last() {
    # Save the last command to a snippet
    name="$1"
    content="$(history | tail -n 1 | head -n 1 | cut -b 8-)"
    snippet-write "$name" "$content"
    zshnip-source
}

zshnip-edit-and-expand() {
    emulate -L zsh

    if [ -z "$BUFFER" ]; then
        # Useful binding to re-edit the last snippet if it was not right
        _zshnip-edit "$_zshnip_last_expanded"
        return
    fi;

    _zshnip-parse-snippet
    LBUFFER=$snippet_new_lbuffer
    _zshnip-edit "$snippet_match" _zshnip-edit-finished-callback
}
zle -N zshnip-edit-and-expand

_zshnip-edit-finished-callback() {
    local defined
    defined=$1
    _zshnip-log "Snippet edit finished"
    zshnip-source
    defining=$_zshnip_
    _zshnip-expand "$defined"
}

_zshnip-expand () {
    local snippet
    snippet=$1
    _zshnip-log "Expanding $snippet"
    _zshnip-log "Buffer before expansion ${LBUFFER}_${RBUFFER}"
    LBUFFER=${LBUFFER%$snippet}
    LBUFFER+=${snippets[$snippet]:-$snippet}
    _zshnip_last_expanded=$snippet
    _zshnip-log "Buffer after expansion ${LBUFFER}_${RBUFFER}"
}

zshnip-enable-log() {
    zshnip_should_log=1 # non-empty to log
}

zshnip-disable-log() {
    zshnip_should_log= # non-empty to log
}

_zshnip-parse-snippet(){
    # Wouldn't it be great if we could return
    #   composite data types
    emulate -L zsh
    setopt extendedglob

    snippet_new_lbuffer=${LBUFFER%%(#m)[.\-+:|_a-zA-Z0-9]#}
    snippet_match=$MATCH
}

_zshnip-do-list(){
    local help="$(print "Add snippet:";
        print "zshnip-add <key> <expansion>";
        print "Snippets:";
        print -a -C 2 ${(kv)snippets})"
    if [[ "$1" = "inZLE" ]]; then
        zle -M "$help"
    else
        echo "$help" | ${PAGER:-less}
    fi
}

zshnip-list(){
    _zshnip-do-list inZLE
}
zle -N zshnip-list
