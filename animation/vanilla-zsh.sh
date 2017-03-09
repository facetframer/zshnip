#!/bin/bash
set -o nounset
set -o pipefail

here="$(dirname ${BASH_SOURCE[0]})"
source $here/util.sh

config=$(mktemp -d)
cat > $config/.zshrc <<EOF
PROMPT="ZSH> "
source ~/.extraconfig/code/zgen/zgen.zsh
zgen load willghatch/zsh-snippets
snippet-add lv $'I love '
snippet-add l $' | less'
snippet-add g $' | grep '
snippet-add gs $'git status '
snippet-add xa $' | xargs '
snippet-add zp $'\$\(ps -ef | fzf-tmux | awk \'{ print \$2 }\'\)'

snippets_file=$config/snippets
bindkey '\ej' snippet-expand-or-edit
EOF

ZDOTDIR=$config /usr/bin/zsh -i
