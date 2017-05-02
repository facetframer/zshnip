#!/bin/bash

here="$(dirname ${BASH_SOURCE[0]})"

exec 2> /tmp/damnlog

source "$here/util.sh"
log "$0 started"

# hack to work with i3
sleep 1;
i3-msg -t command "floating enable" > /dev/null 2>&1 || true;

"$@"
