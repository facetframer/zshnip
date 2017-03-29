#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail


here="$(dirname ${BASH_SOURCE[0]})"
source "$here/util.sh"
source "$here/zsh-animate.sh"

setup-logs
$here/spawn-term.sh "$here/animate-init.sh"
tail -f /tmp/log &
animation-wait-until-finished
