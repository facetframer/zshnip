#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm -f /tmp/log
touch /tmp/log

here="$(dirname ${BASH_SOURCE[0]})"
source $here/util.sh

asciinema-term.sh $here/animation.json $here/animate-init.sh

tail -f /tmp/log
