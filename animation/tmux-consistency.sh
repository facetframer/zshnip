# Code for consistency testing using tmux (taking screenshots)

# This approach prevents us from running two things at the same time
tmux_consistency_errors=/tmp/zshnip-errors

tmux-consistency-init () {
    rm -f "$tmux_consistency_errors"
    touch "$tmux_consistency_errors"
}

tmux-consistency-check-point () {
    local name filename consistency_file
    name=$1
    filename=$(mktemp)
    tmux -S "$TMUX" capture-pane; tmux -S "$TMUX" save-buffer - > "$filename"
    consistency_file=consistency-test/$name
    if ! diff "$filename" "$consistency_file" > /dev/null 2>&1 ; then
       echo "Consistency test $name failed: run diff $filename $consistency_file; run cp $filename $consistency_file to accept changes " >> "$tmux_consistency_errors"
    fi;
}

tmux-consistency-show-errors () {
    errors="$(cat $tmux_consistency_errors)"
    if [ -n "$errors" ]; then
        cat "$tmux_consistency_errors" >&2
        exit 1;
    fi;
}
