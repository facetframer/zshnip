#!/bin/bash
set -o nounset
set -o pipefail
# A zsh which doesn't run commands but has a full zle

here="$(dirname ${BASH_SOURCE[0]})"
source $here/util.sh

# As close as possible to how others will use this script
remote_install_command="
    zplug facetframer/zshnip 2> /dev/null
    sleep 1
    zplug install 2> /dev/null
    zplug load
"

local_install_command="
    source $here/../zshnip.zsh
"""

if [ -f "$here/zshnip-local" ]; then
    install_command="$local_install_command";
else
    install_command="$remote_install_command";
fi;


config=$(mktemp -d)
cat > $config/.zshrc <<EOF
PROMPT="ZSH> "
source /usr/share/zplug/init.zsh
$install_command

zshnip-add wt $'Welcome to '
zshnip-add one $' * Make using zsh more fun'
zshnip-add two $' * Reduce the number of mistakes you make'
zshnip-add three $' * Allow you to do more complicated things'

donothing () {
   zle send-break
}

zle -N accept-line donothing

zshnip_snippets_file=$config/snippets
bindkey '\ej' zshnip-expand-or-edit
EOF

ZDOTDIR=$config /usr/bin/zsh -i
