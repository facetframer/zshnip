#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

here="$(dirname ${BASH_SOURCE[0]})"
source $here/util.sh
source "$here/zsh-animate.sh"
source "$here/zshnip-animation-utils.sh"
source "$here/tmux-consistency.sh"

tmux-consistency-init

workdir="$1"
finished_file=$workdir/finished
animation-attach "$workdir"

spawn-command-window
run-type 1 "new"
sleep 1
tab
sleep 2
tmux-consistency-check-point "define-prompt"
run-type 1 "echo this is a new snippet"
sleep 1
tmux-consistency-check-point "define-input"
run
sleep 1
run
sleep 1
tmux-consistency-check-point "define-expansion"
run-type 1 "new"
sleep 1
tab
sleep 1
tmux-consistency-check-point "define-definition-use"
run
sleep 3
tmux-consistency-check-point "define-execution-works"
animation-finished
