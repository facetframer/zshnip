
here="$(dirname ${BASH_SOURCE[0]})"

if [ -e "$here/debug" ]; then
    set -o xtrace
    exec 2>> /tmp/log
fi;
