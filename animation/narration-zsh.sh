#!/bin/bash

# A stripped down zsh that we can use for narration

set -o errexit
set -o nounset
set -o pipefail

here="$(dirname ${BASH_SOURCE[0]})"
source $here/util.sh

message_dir=$(mktemp -d)
cat >$message_dir/.zshrc <<EOF
PS1=
unsetopt ZLE
unsetopt PROMPT_SP
stty -echo
tput civis

EOF

ZDOTDIR=$message_dir zsh -i
