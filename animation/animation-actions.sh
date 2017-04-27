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
    sleep 0.5
    run
    sleep 0.5
    run
    sleep 0.5
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
    message "'By facet (http://www.facetframer.com/'"
    message "'         -- facet@facetframer.com)'"
    message "'    Copyright 2017 -- Licensed under LGPLv3'"
    message ""
    message ""
    message "'Adapted from 'willghatch\'s'  '"
    message "'         -- https://github.com/willghatch/zsh-snippets '"
    message "'  (public domain) -- Adapted from code in forums'"
    # message "15"
    # message "16"
    # message "17"
    # message "18"
    # message "19"
    # message "20"
    sleep 7

    clear-messages

}

play-introduction-text () {
    message "'Zshnip extends zsh by defining *snippets*: '"
    sleep 2
    message "blocks of text that you can quickly paste into your shell."
    message ""

    sleep 3

    message "'You expand your snippet by running'"
    message "'zshnip-expand-or-edit (using M-x)'"
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
    message "The distinguishing feature of zshnip is that you can define snippets as you go:"
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
    message "'        If you are wrong the new binding'"
    message "'         is probably better'"
    sleep 1;
    message "'   You actually get around to defining snippets'"
    sleep 2
    message "'   Defining snippets is faster'"
    sleep 2
    message "'        No need to find configurations files'"
    message "'        and open them'"
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
    run-word "ps -ef l"
    sleep 1
    tab
    sleep 1
    run
    sleep 2
    run-word "q"
    sleep 1
    message "Grepping..."
    message ""
    sleep 1
    run-word "ps -ef g"
    sleep 1
    tab
    sleep 1
    run-type 1 "zsh "
    sleep 1
    run-word "l"
    sleep 1
    tab
    sleep 1
    run
    sleep 1
    run q
    run clear
    sleep 1

    message "Git ..."
    message ""
    run "clear"
    run-word "gs"
    sleep 2
    tab
    sleep 2
    run
    sleep 1

    message "Post processing..."
    message ""

    sleep 1
    run-word "ps -ef w2"
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
    run-word "ps -ef g"
    tab
    sleep 1
    run-word "cat "
    sleep 1
    run-word "w2"
    sleep 1
    tab
    sleep 1
    run
    sleep 2

    run-word "!! xak"
    sleep 1
    tab
    sleep 1
    run
    sleep 2

    message "'(Pseudo)completion (using fzf) ...'"
    message ""
    run "clear"
    sleep 1
    run-word "kill zp"
    sleep 1
    tab
    sleep 1
    run-word "$(echo -e '\x03')"
    message ""

    sleep 3
    clear-messages
}

play-credits () {
    message "'To download go here:'"
    message "'    https://github.com/facetframer/zshnip'"
    message ''
    message "'For more about me:'"
    message "'    Facet (facet@facetframer.com)'"
    message "'    @facetframer'"
    message "'    http://www.facetframer.com/'"
    message
    message "For more about willghatch"
    message "'    http://willghatch.net/blog/'"
    sleep 10
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

sleep 1

animation-finished
