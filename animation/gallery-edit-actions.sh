#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

here="$(dirname ${BASH_SOURCE[0]})"
source $here/util.sh
source "$here/zsh-animate.sh"
source "$here/zshnip-animation-utils.sh"

workdir="$1"
finished_file=$workdir/finished
animation-attach "$workdir"

spawn-command-window
run-type 1 "edit"
sleep 1
edit-key
sleep 2
run-type 1 "edited: "
sleep 1
run
sleep 1
run
sleep 1
animation-finished
animation-wait-until-finished
