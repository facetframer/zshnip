#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail


title=$1
action_file=$2
output_file=$3

here="$(dirname ${BASH_SOURCE[0]})"
source "$here/util.sh"
source "$here/zsh-animate.sh"
setup-logs
$here/spawn-term.sh "$here/animate-init.sh" "$title" "$action_file" "$output_file"
tail -f /tmp/log &
