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
run-type 1 "GSP"
sleep 1
tab
sleep 1
tmux-consistency-check-point "nest-defining"
run-type 1 "GS"
sleep 1
tab
sleep 1
tmux-consistency-check-point "nest-defining-2"
run-type 1 "G"
sleep 1
tab
tmux-consistency-check-point "nest-defining-3"
sleep 1;
run-type 1 "git "
run
sleep 1
tmux-consistency-check-point "nest-defined-3"
run-type 1 "status "
run
sleep 1
tmux-consistency-check-point "nest-defined-2"
run-type 1 " --porcelain"
run
sleep 1
tmux-consistency-check-point "nest-defined-1"
run
sleep 1
tmux-consistency-check-point "nest-executed"
animation-finished
