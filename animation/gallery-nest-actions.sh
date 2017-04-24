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
run-type 1 "GSP"
sleep 1
tab
sleep 1
run-type 1 "GS"
sleep 1
tab
sleep 1
run-type 1 "G"
sleep 1
tab
run-type 1 "git "
run
sleep 1
run-type 1 "status "
run
sleep 1
run-type 1 " --porcelain"
run
sleep 1
run
sleep 1
animation-finished
animation-wait-until-finished
