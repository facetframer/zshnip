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
run-type 1 "echo -e 'hello\nworld' grs"
sleep 1
tab
sleep 1
run-type 1 ' | grep "^"'
back-key
sleep 1
run
sleep 1
tmux-consistency-check-point "insertion-defining"
run
sleep 1
run-type 1 "echo -e 'hello\nworld' grs"
sleep 1
tab
sleep 1
run-type 1 "h"
sleep 1
tmux-consistency-check-point "insertion-expanding"
run
sleep 3
animation-finished
