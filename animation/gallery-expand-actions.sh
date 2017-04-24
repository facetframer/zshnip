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
run-type 1 "gs"
sleep 1
tab
tmux-consistency-check-point "expand-correct"
sleep 3
animation-finished

