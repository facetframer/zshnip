# Functions to animating zsh

here="$(dirname ${BASH_SOURCE[0]})"

narration_pane=narration.0
# Where we should send commands
command_pane=

message () {
tmux -S $TMUX send-keys -t "$narration_pane" "echo $*
"
}


animate-set-command-pane (){
    command_pane="$1"

}

message-more () {
tmux -S $TMUX send-keys -t "$narration_pane" "echo -n $*
"
}

clear-messages() {
tmux -S $TMUX send-keys -t "$narration_pane" "clear
"
}

characters () {
    echo "$*" | sed -E 's/(.)/\1\n/g'
}

run-type () {
    speed="$1"
    shift
    echo -n "$*" | tmux-type "$command_pane" "$speed"
}

message-type-stream () {
    while read c; do tmux -S $TMUX send-keys -t "$1" "echo -n '$c'
"; sleep 0.2; done
}

tmux-type () {
    # Using "while read" was chocking on backslashes:
    #   use a more predictable language
    python $here/tmux-animate.py -S "$TMUX" type "$1" --speed "$2"
}


message-type () {
    characters $* | message-type-stream "$narration_pane"
}

run () {
    tmux -S $TMUX send-keys -t "$command_pane" "$*
"
}

run-more () {
    tmux -S $TMUX send-keys -t "$command_pane" "$*"
}

run-word () {
    tmux -S $TMUX send-keys -t "$command_pane" "$*"
}

tab () {
    tmux -S "$TMUX" send-keys -t "$command_pane" $(echo -e '\ej')
}

message-tab () {
    tmux -S "$TMUX" send-keys -t "$narration_pane" $(echo -e '\ej')
}

animation-init-tmux () {
    workdir=$(mktemp -d)
    finished_file=$workdir/finished
    TMUX=$workdir/mux

    # Kill off old sessions
    tmux -S $TMUX kill-server 2>/dev/null  || true
    sleep 1;

    # start a zsh
    tmux -S $TMUX new-session -d -y 10 -x 10
    echo "$TMUX"
}

animation-attach () {
    # Attach to an existing animation (for example from a subscript)
    workdir=$1
    finished_file=$workdir/finished

}

animation-finished () {
    touch "$finished_file"
}

animation-wait-until-finished () {
    while [ ! -f "$finished_file" ]; do
        sleep 1;
    done;
    animation-cleanup-tmux;
}

animation-cleanup-tmux () {
    # This is necessary to get asciinema to cleanly exit (i.e not truncate recording

    #ps -ef | grep asciinema | awk '{ print $2 }' | xargs -n 1 kill -INT


    if [ -n "$(tmux -S "$TMUX" list-client)" ]; then
        tmux -S "$TMUX" list-client  | cut -d: -f 1  | xargs -n 1 tmux -S "$TMUX" detach-client -t
    fi;

    sleep 10;

    tmux -S "$TMUX" kill-server
}

animation-record () {
    # Start recording the animation in the background
    log "RECORDING"
    asciinema rec -t "$1" -c "tmux -S $TMUX attach" "$2"
    log "FINISHED"
}

animation-watch () {
    # Watch an animation in the current window
    tmux -S "$TMUX" attach
}

animation-xwindow-watch () {
    # Watch an animation in a new x window
    here="$(dirname ${BASH_SOURCE[0]})"
    $here/spawn-term.sh "tmux -S $TMUX attach \\; select-window -t test"
}
