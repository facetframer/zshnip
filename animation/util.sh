
here="$(dirname ${BASH_SOURCE[0]})"

if [ -e "$here/debug" ]; then
    set -o xtrace
    exec 2>> /tmp/log
fi;

log () {
    echo "$*" >> /tmp/log
}

setup-logs () {
    rm -f /tmp/log
    touch /tmp/log
}
