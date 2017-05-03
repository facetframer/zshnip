#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

here="$(dirname ${BASH_SOURCE[0]})"
source $here/util.sh
source "$here/zsh-animate.sh"
source "$here/zshnip-animation-utils.sh"

workdir="$1"
finished_file=$workdir/finished
animation-attach "$workdir"

play-interactive-banner () {
    run-type 1 "wt"
    tab
    sleep 2;
    run-type 1 "zs"
    sleep 1
    tab
    sleep 1;
    run-type 1 "Zshnip"
    sleep 0.5;
    run ""
    sleep 1;
    run ""
    run-type 1 "zs"
    sleep 1;
    tab
    sleep 0.7;
    run-type 1.5 " is a tool to:"
    run ""

    sleep 1
    run-type 1 "one"
    sleep 1
    tab
    sleep 1
    run

    sleep 1
    run-type 1 "two"
    sleep 1
    tab
    sleep 1
    run

    sleep 1
    run-type 1 "three"
    sleep 1
    tab
    sleep 1
    run

    sleep 1

    run-type 1 " * All without..."
    sleep 1
    run
    sleep 1
    run-more "      EVER "
    sleep 1
    run-more "HAVING "
    sleep 1
    run-more "TO "
    sleep 0.3
    run-more "DO "
    sleep 0.3
    run-more "ANY "
    sleep 0.8
    run-more "CONFIGURATION"
    sleep 2
    run-more "*"

    run
    sleep 0.2
    run
    sleep 0.2
    run
    sleep 0.2
    run "                * apart from installing zshnip"

    sleep 3
}



play-banner () {
    message-more "'Welcome to Zshnip'"
    sleep 2
    message ""
    message "A tool to:"
    sleep 2
    message "'  * Make using zsh more fun'"
    sleep 2
    message "'  * Reduce the number of mistakes you make'"
    sleep 2
    message "'  * Allow you to do more complicated things'"
    sleep 3
    message "'  * All without...'"
    message

    sleep 1
    message-more "'      EVER '"
    sleep 1
    message-more "'HAVING '"
    sleep 1
    message-more "'TO '"
    sleep 0.3
    message-more "'DO '"
    sleep 0.3
    message-more "'ANY '"
    sleep 0.8
    message-more "'CONFIGURATION'"
    sleep 2
    message-more "'*'"

    message
    message
    message
    message "'                * apart from installing zshnip'"

    sleep 3
}

play-attribution () {

    message ""
    message ""
    message ""
    message ""
    message "'By facet (http://www.facetframer.com/ --  facet@facetframer.com)'"
    message "'    Copyright 2017 -- Licensed under LGPLv3'"
    message ""
    message ""
    message "'Adapted from 'willghatch\'s' https://github.com/willghatch/zsh-snippets '"
    message "'  (public domain) -- Adapted from code in forums'"
    sleep 7

    clear-messages

}

play-introduction-text () {
    message-more "'Zshnip extends zsh by defining *snippets*: '"
    sleep 2
    message "blocks of text that "
    message "you can quickly paste into your shell."
    message ""

    sleep 3

    message "'You expand your snippet by running zshnip-expand-or-edit'"
    message "'(using M-x)'"
    sleep 2
}

play-introduction-snippet () {
    sleep 1
    run-type 1 "echo lv"
    run-word "$(echo -e '\ex')"
    run-type 1 "zshnip-expand-or-edit"
    sleep 1;
    run ""

    run-type 1 Zshnip
    run ""
}

play-keybindings () {
    clear-messages
    message "'(You probably want a keybinding for this.) vvvv'"

    sleep 3
    run-type 2 "bindkey '\\ej' zshnip-expand-or-edit"
    run
    sleep 2
    clear-messages
}

play-define-as-you-go () {
    sleep 2
    message "The distinguishing feature of zshnip is that you can define"
    message "snippets as you go:"
    sleep 2
    run "clear"
    run-type 1 "echo zs"
    sleep 1
    message "'   ** KEYPRESS: M-j ** '"
    sleep 0.5
    tab

    sleep 2;

    message ""
    message "If a snippet is not defined then a prompt is displayed"
    message "for you to define it."
    sleep 1
    run-type 1 "Zshnip "
    message "'   ** KEYPRESS: Return ** '"
    sleep 1
    run ""
    message ""
    message "You can then immediately use your snippet."
    sleep 1
    sleep 1;
    run ""
    sleep 1

    run-word "echo zs"
    sleep 1
    message "'   ** KEYPRESS: M-j ** '"
    sleep 1
    tab
    run-type 1 " is awesome"
    sleep 1
    run ""

    sleep 2

    clear-messages
}

play-benefits () {
    sleep 1
    message "The acts of defining and expanding are combined."
    message ""

    sleep 1

    message "'This has some (claimed) benefits:'"
    sleep 2
    message "'   You need to remember less -- just guess'"
    sleep 1
    message "'        If you are wrong the new binding is probably better'"
    sleep 1;
    message "'   You actually get around to defining snippets'"
    sleep 2
    message "'   Defining snippets is faster'"
    sleep 2
    message "'        No need to find configurations files and open them'"
    sleep 2
    message "'   Your capacity to go down an automation rabbit-hole'"
    message "'   is reduced'"
    sleep 2
    message "'       You have a programming tool of reduced power'"
    sleep 2
}


play-examples () {
    sleep 4
    clear-messages
    sleep 2
    message "Now I shall woo you with amazing use cases..."
    message ""
    sleep 2
    message "Pagers..."
    message ""
    sleep 1
    run-type 1 "ps -ef l"
    sleep 1
    tab
    sleep 1
    run
    sleep 2
    run-type 1 "q"
    sleep 1
    message "Grepping..."
    message ""
    sleep 1
    run-type 1 "ps -ef g"
    sleep 1
    tab
    sleep 1
    run-type 1 "zsh "
    sleep 1
    run
    sleep 1
    run q
    run clear
    sleep 1

    message "Git ..."
    message ""
    run "clear"
    run-type 1 "gs"
    sleep 2
    tab
    sleep 2
    run
    sleep 1

    message "Post processing..."
    message ""

    sleep 1
    run-type 1 "ps -ef w2"
    sleep 1
    tab
    run-word " "
    sleep 2
    message "Sorting..."
    message ""
    run-word "s"
    sleep 1
    tab
    sleep 1
    run
    sleep 3

    message "Killing..."
    message ""
    run "cat &"
    sleep 2
    run-type 1 "ps -ef g"
    tab
    sleep 1
    run-type 1 "cat "
    sleep 1
    run-type 1 "w2"
    sleep 1
    tab
    sleep 1
    run
    sleep 2

    run-type 1 "!! xak"
    sleep 1
    tab
    sleep 1
    run
    sleep 2

    message "'(Pseudo)completion (using fzf)...'"
    message ""
    run "clear"
    sleep 1
    run-type 1 "kill zp"
    sleep 1
    tab
    sleep 1
    run-word "$(echo -e '\x03')"

    sleep 3

    message "'Snippet arguments...'"
    message ""
    run "clear"
    sleep 1
    run-type 1 "arguments"
    sleep 1
    tab
    sleep 1
    run-type 1 "Jim"
    run

    sleep 3
    clear-messages
}

play-credits () {
    message "'To download go here:'"
    sleep 1
    message "'    https://github.com/facetframer/zshnip'"
    sleep 1
    message ''
    sleep 1
    message "'For more about me:'"
    sleep 1
    message "'    Facet (facet@facetframer.com)'"
    sleep 1
    message "'    @facetframer'"
    sleep 1
    message "'    http://www.facetframer.com/'"
    sleep 1
    message
    sleep 1
    message "For more about willghatch"
    sleep 1
    message "'    http://willghatch.net/blog/'"
    sleep 1
    message-more '.'
    sleep 1

    message-more '.'
    sleep 1
    message-more '.'
    sleep 1
    message-more '.'
    sleep 1
    message-more '.'
    sleep 1
    message-more '.'
    sleep 1
    message-more '.'
    sleep 1
}

close-shell () {
tmux send-keys -t "$command_pane" 'exit
'
}

sleep 1;
#play-banner
tmux -S $TMUX select-window -t pseudoshell
animate-set-command-pane "pseudoshell.0"
sleep 1;
play-interactive-banner

sleep 1;
spawn-narration-window;

play-attribution
play-introduction-text
split-command-window
sleep 1;
play-introduction-snippet
play-keybindings
play-define-as-you-go
play-benefits
play-examples
close-shell
play-credits

sleep 15
clear

animation-finished
