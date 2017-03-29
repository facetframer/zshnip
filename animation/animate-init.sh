#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

here="$(abspath $(dirname ${BASH_SOURCE[0]}))"
source "$here/util.sh"
source "$here/zsh-animate.sh"
log "$0 started"

workdir=$(mktemp -d)
finished_file=$workdir/finished

TMUX=$(animation-init-tmux)

tmux -S $TMUX new-window -n test $here/narration-zsh.sh

# Start recording in the background
animation-record "$here/animation.json"

# Start animation thread
$here/animation-actions.sh "$workdir" &

tmux -S $TMUX attach


rm -rf "$workdir"
