#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

here="$(abspath $(dirname ${BASH_SOURCE[0]}))"
source "$here/util.sh"
source "$here/zsh-animate.sh"
log "$0 started"

title=$1
action_file=$2
output_file=$3

workdir=$(mktemp -d)
finished_file=$workdir/finished

TMUX=$(animation-init-tmux)

tmux -S $TMUX new-window -n pseudoshell "$here/pseudo-shell-zsh.sh"

# Start recording in the background
sleep 1;

# Start animation thread
bash "$action_file" "$workdir" &

animation-record "$title" "$here/animation.json"

cat animation.json | jq  '.stdout=.stdout[:-2]' > new-animation.json
mv new-animation.json "$output_file"

rm -rf "$workdir"
