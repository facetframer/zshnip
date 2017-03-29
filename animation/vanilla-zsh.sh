#!/bin/bash
set -o nounset
set -o pipefail

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

zshnip-add lv $'I love '
zshnip-add l $' | less'
zshnip-add g $' | grep '
zshnip-add gs $'git status '
zshnip-add s $' | sort '
zshnip-add xa $' | xargs '
zshnip-add w2 $' | awk \'{ print \$2 } \' '
zshnip-add xak $' | xargs -n 1 kill -9 '
zshnip-add zp $'\$\(ps -ef | fzf-tmux | awk \'{ print \$2 }\'\)'

snippets_file=$config/snippets
bindkey '\ej' snippet-expand-or-edit
EOF

ZDOTDIR=$config /usr/bin/zsh -i
