# Functions to animating zsh

narration_pane=test.0
command_pane=test.1

message () {
tmux -S /tmp/mux send-keys -t "$narration_pane" "echo $*
"
}

message-more () {
tmux -S /tmp/mux send-keys -t "$narration_pane" "echo -n $*
"
}

clear-messages() {
tmux -S /tmp/mux send-keys -t "$narration_pane" "clear
"
}

characters () {
    echo "$*" | sed -E 's/(.)/\1\n/g'
}

run-type () {
    speed=$(calc 0.2 / $1)
    shift;
    characters "$*" | tmux-type "$command_pane" $speed
}

message-type-stream () {
    while read c; do tmux -S /tmp/mux send-keys -t "$1" "echo -n '$c'
"; sleep 0.2; done
}

tmux-type () {
    while IFS='' read c ; do tmux -S /tmp/mux send-keys -t "$1" "$c"; sleep 0.2; done
}


message-type () {
    characters $* | message-type-stream "$narration_pane"
}

run () {
    tmux -S /tmp/mux send-keys -t "$command_pane" "$*
"
}

run-word () {
tmux -S /tmp/mux send-keys -t "$command_pane" "$*"
}

tab () {
    tmux send-keys -t "$command_pane" "$(echo -e '\ej')"
}

