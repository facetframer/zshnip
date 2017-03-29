#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

here="$(dirname ${BASH_SOURCE[0]})"



source  "$here/util.sh"
source "$here/zsh-animate.sh"
source "$here/zsh-animate.sh"
source "$here/zshnip-animation-utils.sh"

tail -f /tmp/log &
tail_pid=$!
clean-up() {
    if [ -n "${tail_pid:-}" ]; then
        kill $tail_pid > /dev/null || true 
    fi;
}
trap clean-up EXIT

animation-init-tmux
TMUX=$(animation-init-tmux)

spawn-command-window
sleep 1;

test-steps () {
    sleep 1;
    run "hello"
    run "bindkey '\\ej' zshnip-expand-or-edit"
    run-word "echo snippet"
    sleep 2
    tab
    sleep 1;
    run-word "this is a test snippet"
    sleep 1;
    run ""
    sleep 1;
    animation-finished
}

test-steps &
tail_pid=$!
animation-xwindow-watch
animation-wait-until-finished
