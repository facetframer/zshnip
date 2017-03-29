#!/usr/bin/env zsh
# snippets for expansion anywhere in the command line
# taken from http://zshwiki.org/home/examples/zleiab and expanded somewhat
#
# use: add-snippet <key> <expansion>
# then, with cursor just past <key>, run zshnip-expand

zshnip_should_log= # empty to prevent logging

snippets_file=~/.zshnip
#snippet_edit_func=snippet-editor-edit
zshnip_edit_func=zshnip-shell-edit

typeset -Ag snippets

zshnip-log() {
    if [ -n "${zshnip_should_log:-}" ]; then
        zshnip-warn "$*"
    fi;
}

zshnip-warn() {
    echo >&2 "zshnip: $*"
}

zshnip-add() {
    # zshnip-add <key> <expansion>
    snippets[$1]="$2"
}

zshnip-exists() {
    [ -n "${snippets[$1]:-}" ];
}

zshnip-editor-edit() {
    name="$1"
    zshnip-log "Editing $name"
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

zshnip-line-restore () {
    LBUFFER="$CURRENT_SNIP_LINE"
}
zle -N zshnip-line-restore

set -A zshnip_shell_defining
zshnip-shell-edit() {
    emulate -L zsh
    setopt extendedglob
    zshnip_shell_defining="$1"
    zshnip_shell_before_snippet="$BUFFER"
    zshnip-log "Setting buffer to expansion of $snippet_match"
    new_buffer="$snippets[$1]"
    BUFFER=$new_buffer
    OLDPROMPT="$PROMPT"
    PROMPT="$PROMPT DEFINING SNIPPET: $zshnip_shell_defining > "
    zle reset-prompt
    PROMPT="$OLDPROMPT"
    zle -N accept-line zshnip-shell-edit-finished
}
zle -N zshnip-shell-edit

zshnip-shell-edit-finished() {
    emulate -L zsh
    local new_snippet
    local defining

    defining="$zshnip_shell_defining"
    zshnip_shell_defining=

    zshnip-write "$defining" "$BUFFER"

    zshnip-source

    zle -N accept-line .accept-line
    LBUFFER="$zshnip_shell_before_snippet"
    zle reset-prompt

    zshnip-edit-finished-callback
}
zle -N zshnip-shell-finished

zshnip-source () {
    if [ -f "$snippets_file" ]; then
        source "$snippets_file"
    fi;
}

zshnip-write () {
    name=$1
    content=$2

    zshnip-log "Setting snippet '$name' to '$content'"

    escaped_content=$(echo "$content" | sed "s/'/\\\\'/g" )
    echo zshnip-add "$name" $'$\''"$escaped_content""'" >> $snippets_file
}

zshnip-expand() {
    emulate -L zsh
    setopt extendedglob
    zshnip-parse-snippet
    LBUFFER=$snippet_new_lbuffer
    LBUFFER+="${snippets[$snippet_match]:-$snippet_match}"
}
zle -N zshnip-expand

zshnip-string-expand () {
    echo "${snippets[$snippet_match]:-$snippet_match}"
}


zshnip-expand-or-edit() {
    zshnip-parse-snippet
    LBUFFER=$snippet_new_lbuffer
    if [ -z "${snippets[$snippet_match]:-}" ]; then
        $zshnip_edit_func "$snippet_match"
    else
        zshnip-edit-finished-callback
    fi;

}
zle -N zshnip-expand-or-edit

zshnip-save-last() {
    name="$1"
    content="$(history | tail -n 1 | head -n 1 | cut -b 8-)"
    snippet-write "$name" "$content"
    zshnip-source
}

zshnip-edit-and-expand() {
    emulate -L zsh

    if [ -z "$BUFFER" ]; then
        # Useful binding to re-edit the last snippet if it was not right
        $zshnip_edit_func "$snippet_match"
        return
    fi;

    zshnip-parse-snippet
    LBUFFER=$snippet_new_lbuffer
    $zshnip_edit_func "$snippet_match" zshnip-edit-finished-callback
}
zle -N zshnip-edit-and-expand

zshnip-edit-finished-callback() {
    zshnip-log "Snippet edit finished"
    zshnip-source
    LBUFFER+=${snippets[$snippet_match]:-$snippet_match}
}

zshnip-parse-snippet(){
    # Wouldn't it be great if we could return
    #   composite data types
    emulate -L zsh
    setopt extendedglob

    snippet_new_lbuffer=${LBUFFER%%(#m)[.\-+:|_a-zA-Z0-9]#}
    snippet_match=$MATCH
    zshnip-log "Found snippet $snippet_match"
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
