#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# Spawn a terminal of a suitable size for an animation
here="$(dirname ${BASH_SOURCE[0]})"
mate-terminal --geometry 60x18 -e "$here/spawn-term-inner.sh $*"
