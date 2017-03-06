#!/usr/bin/env zsh
# snippets for expansion anywhere in the command line
# taken from http://zshwiki.org/home/examples/zleiab and expanded somewhat
#
# use: add-snippet <key> <expansion>
# then, with cursor just past <key>, run snippet-expand

snippets_should_log=yes # empty to prevent logging

snippets_file=~/.zsh-snippets
#snippet_edit_func=snippet-editor-edit
snippet_edit_func=snippet-shell-edit

typeset -Ag snippets

snippet-log() {
    if [ -n "${snippets_should_log:-}" ]; then
        echo >&2 "$*"
    fi;
}

snippet-add() {
    # snippet-add <key> <expansion>
    snippets[$1]="$2"
}

snippet-exists() {
    [ -n "${snippets[$1]:-}" ];
}

snippet-editor-edit() {
    name="$1"
    snippet-log "Editing $name"
    filename=$(mktemp)
    echo "$snippets[$snippet_match]" > "$filename"
    finished=$(mktemp --dry-run)
    tmux new-window bash -c "vim -c 'startinsert' $filename; touch $finished"

    # This can't handle a save and edit
    #   to support this we some sort of signal
    while [ ! -e "$finished" ]; do
        sleep 0.1;
    done;
    snippet-write "$name" "$(cat $filename)"
}

snippet-line-restore () {
    LBUFFER="$CURRENT_SNIP_LINE"
}
zle -N snippet-line-restore

set -A snippet_shell_defining
snippet-shell-edit() {
    emulate -L zsh
    setopt extendedglob
    snippet_shell_defining="$1"
    snippet_shell_before_snippet="$BUFFER"
    snippet-log "Setting buffer to expansion of $snippet_match"
    new_buffer="$snippets[$1]"
    BUFFER=$new_buffer
    zle -N accept-line snippet-shell-edit-finished
}
zle -N snippet-shell-edit

snippet-shell-edit-finished() {
    emulate -L zsh
    local new_snippet
    local defining

    defining=$snippet_shell_defining
    snippet_shell_defining=

    snippet-write "$defining" "$BUFFER"
    source $snippets_file
    zle -N accept-line .accept-line
    LBUFFER="$snippet_shell_before_snippet"

    snippet-edit-finished-callback
}
zle -N snippet-shell-finished



snippet-write () {
    name=$1
    content=$2

    snippet-log "Setting snippet $name to $content"

    escaped_content=$(echo "$content" | sed "s/'/\\\\'/g" )
    echo snippet-add "$name" $'$\''"$escaped_content""'" >> $snippets_file
}

snippet-expand() {
    emulate -L zsh
    setopt extendedglob
    parse-snippet
    LBUFFER=$snippet_new_lbuffer
    LBUFFER+=${snippets[$snippet_match]:-$snippet_match}
}
zle -N snippet-expand

snippet-string-expand () {
    echo "${snippets[$snippet_match]:-$snippet_match}"
}


snippet-expand-or-edit() {
    parse-snippet
    LBUFFER=$snippet_new_lbuffer
    if [ -z "${snippets[$snippet_match]:-}" ]; then
        $snippet_edit_func "$snippet_match"
    else
        snippet-edit-finished-callback
    fi;

}
zle -N snippet-expand-or-edit

snippet-save-last() {
    name="$1"
    content="$(history | tail -n 1 | head -n 1 | cut -b 8-)"
    snippet-write "$name" "$content"
    source "$snippets_file"
}

snippet-save-following() {
    name="$1"
    zle recursive-edit
    snippet-save-last $name
}

snippet-edit-and-expand() {
    emulate -L zsh

    if [ -z "$BUFFER" ]; then
        # Useful binding to re-edit the last snippet if it was not right
        $snippet_edit_func "$snippet_match"
        return
    fi;

    parse-snippet
    LBUFFER=$snippet_new_lbuffer
    $snippet_edit_func "$snippet_match" snippet-edit-finished-callback
}
zle -N snippet-edit-and-expand

snippet-edit-finished-callback() {
    snippet-log "Snippet edit finished"
    source $snippets_file
    LBUFFER+=${snippets[$snippet_match]:-$snippet_match}
}

parse-snippet(){
    # Wouldn't it be great if we could return
    #   composite data types
    emulate -L zsh
    setopt extendedglob

    snippet_new_lbuffer=${LBUFFER%%(#m)[.\-+:|_a-zA-Z0-9]#}
    snippet_match=$MATCH
    snippet-log "Found snippet $snippet_match"
}

help-list-snippets(){
    local help="$(print "Add snippet:";
        print "snippet-add <key> <expansion>";
        print "Snippets:";
        print -a -C 2 ${(kv)snippets})"
    if [[ "$1" = "inZLE" ]]; then
        zle -M "$help"
    else
        echo "$help" | ${PAGER:-less}
    fi
}
run-help-list-snippets(){
    help-list-snippets inZLE
}
zle -N run-help-list-snippets


# set up some default snippets
snippet-add l      "less "
snippet-add tl     "| less "
snippet-add g      "grep "
snippet-add tg     "| grep "
snippet-add gl     "grep -l"
snippet-add tgl    "| grep -l"
snippet-add gL     "grep -L"
snippet-add tgL    "| grep -L"
snippet-add gv     "grep -v "
snippet-add tgv    "| grep -v "
snippet-add eg     "egrep "
snippet-add teg    "| egrep "
snippet-add fg     "fgrep "
snippet-add tfg    "| fgrep "
snippet-add fgv    "fgrep -v "
snippet-add tfgv   "| fgrep -v "
snippet-add ag     "agrep "
snippet-add tag    "| agrep "
snippet-add ta     "| ag "
snippet-add p      "${PAGER:-less} "
snippet-add tp     "| ${PAGER:-less} "
snippet-add h      "head "
snippet-add th     "| head "
snippet-add t      "tail "
snippet-add tt     "| tail "
snippet-add s      "sort "
snippet-add ts     "| sort "
snippet-add v      "${VISUAL:-${EDITOR:-nano}} "
snippet-add tv     "| ${VISUAL:-${EDITOR:-nano}} "
snippet-add tc     "| cut "
snippet-add tu     "| uniq "
snippet-add tx     "| xargs "
