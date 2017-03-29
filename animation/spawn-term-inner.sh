#!/bin/bash

here="$(dirname ${BASH_SOURCE[0]})"

exec 2> /tmp/damnlog

source "$here/util.sh"
log "$0 started"

i3-msg -t command "floating enable" > /dev/null;

"$@"
