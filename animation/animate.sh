#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail



here="$(dirname ${BASH_SOURCE[0]})"
source "$here/util.sh"
source "$here/zsh-animate.sh"
source "$here/tmux-consistency.sh"

setup-logs

title=$1
action_file=$2
output_file=$3
workdir=$(mktemp -d)

finished_file="$workdir/finished"
TMUX=$workdir/mux

$here/spawn-term.sh "$here/animate-init.sh" "$title" "$action_file" "$output_file" "$workdir"
tail -f /tmp/log &

tmux-consistency-init

animation-wait-until-finished "$workdir"
tmux-consistency-show-errors


