#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

here="$(abspath $(dirname ${BASH_SOURCE[0]}))"
source $here/util.sh

TMUX=/tmp/mux

# Kill off old sessions
tmux -S /tmp/mux kill-server || true
sleep 1;

# Start animation thread
$here/animation-actions.sh &

# start a zsh
tmux -S /tmp/mux new-session -d
tmux -S /tmp/mux new-window -n test $here/narration-zsh.sh

tmux -S /tmp/mux attach
