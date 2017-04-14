# General commands for animation specific to zshnip


here="$(dirname ${BASH_SOURCE[0]})"

split-command-window () {
    tmux -S "$TMUX" split-window -t narration "$here/vanilla-zsh.sh"
    sleep 2;
    command_pane=narration.1
}

spawn-command-window () {
    tmux -S "$TMUX" new-window -n test "$here/vanilla-zsh.sh"
    sleep 2;
    command_pane=test.0
}

spawn-narration-window () {
    tmux -S "$TMUX" new-window -n narration.0 "$here/narration-zsh.sh"
    sleep 2;
    command_pane=test.0
}

die() {
    echo >&2 "$*"
    exit 1
}
