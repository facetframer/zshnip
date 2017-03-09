#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

here="$(dirname ${BASH_SOURCE[0]})"
source $here/util.sh
source $here/zsh-animate.zsh


play-banner () {
    message-more "'Welcome to '"
    sleep 0.5
    message-type "Zshnip"
    message ""
    message ""
    sleep 1;
    message "A tool to magically:"
    sleep 2
    message "'  * Make using the shell more fun'"
    sleep 1
    message "'  * Reduce the number of mistakes you make'"
    sleep 1
    message "'  * Allow you to do more complicated things'"
    sleep 1
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

    clear-messages

}

play-attribution () {
    message ""
    message ""
    message ""
    message ""
    message "'By facet (http://www.facetframer.com/ -- facet@facetframer.com)'"
    message "'      Copyright 2017 -- Licensed under GPLv3'"
    message ""
    message "'  Adapted from' willghatch\'s https://github.com/willghatch/zsh-snippets '(public domain)'"
    message "'  Adapted from code in forums'"
    sleep 7

    clear-messages

}

play-introduction-text () {
    message "An introduction to Zshnip:"
    message
    sleep 1

    message-more "'Zshnip works by defining *snippets*: '"
    sleep 2
    message "blocks of text that you"
    message "  can quickly paste into your shell."
    message ""

    sleep 3

    message-more "'You expand your snippet by running snippet-expand-or-edit. '"
    sleep 2;
}

play-introduction-snippet () {
    sleep 1;
    run-type 1 "echo lv"
    run-word "$(echo -e '\ex')"
    run-type 2 "snippet-expand-or-edit"
    run ""

    run-type 1 Zshnip
    run ""
}

spawn-command-window () {
    tmux -S /tmp/mux split-window -t test $here/vanilla-zsh.sh
}

play-keybindings () {
    clear-messages
    sleep 3;
    message "'(You probably want a keybinding for this.) vvvv'"

    sleep 3;
    run "bindkey '\ej' snippet-expand-or-edit"
    sleep 2
    clear-messages
}

play-define-as-you-go () {
    sleep 2
    message "The distinguishing feature of zshnip is that you can define snippets as you go:"
    sleep 2;
    run "clear"
    run-type 1 "echo zs"
    sleep 2;
    message "   M-j"
    sleep 1;
    tab
    sleep 2;
    run-type 1 "Zshnip "
    message "   Return"
    sleep 1;
    run ""
    run ""
    sleep 1;

    run-word "echo zs"
    sleep 1;
    message "  M-j"
    sleep 1;
    tab
    run-type 1 " is awesome"
    sleep 1;
    run ""

    sleep 2;

    clear-messages
}

play-benefits () {
    sleep 1;
    message "The acts of defining and expanding are combined."
    message ""

    sleep 1;

    message "'This has some (claimed) benefits:'"
    sleep 2;
    message "'   You need to remember less -- just guess.'"
    sleep 2
    message "'      Predictability means you will probably guess the same thing.'"
    message "'      If not define a duplicate snippet for your guess.'"
    message "'      This is probably a better snippet because you guessed it.'"
    message ""
    sleep 2
    message "'   You actually get around to defining snippets.'"
    sleep 2
    message "'      You define snippets as you use them (rather than'"
    message "'      later guessing and forgetting what you need)'"
    message ""
    sleep 2;
    message "'   Defining snippets is faster:'"
    sleep 2
    message "'        No need to find configurations files and open them.'"
    message ""
    sleep 2;
    message "'   Your capacity to go down an automation rabbit-hole is reduced.'"
    sleep 2
    message "'       You have a programming tool of reduced power.'"
    sleep 2
}


play-examples () {
    sleep 4;
    clear-messages
    sleep 2;
    message "Now I\'m going to try to woo you with amazing use cases"
    sleep 2
    message "Pagers..."
    sleep 1;
    run-word "ps -ef l"
    sleep 1;
    tab
    sleep 1
    run
    sleep 2;
    run-word "q"
    sleep 1;
    message "Grepping..."
    sleep 1;
    run-word "ps -ef g"
    sleep 1;
    tab;
    sleep 1;
    run-word "zsh"
    sleep 1;
    run
    message "Git ..."
    run "clear"
    run-word "gs"
    sleep 2
    tab
    sleep 2;
    run
    sleep 1;
    message "'(Pseudo)completion (using fzf) ...'"
    run "clear"
    run-word "kill zp"
    tab
    sleep 1;
    run-word "$(echo -e '\x03')"

    sleep 3;
    message "'Credits...'"

    clear-messages
}

play-credits () {
    message "'To download go here:'"
    message "'    https://github.com/facetframer/zshnip'"

    message "'For more about me:'"
    message "'  Facet (facet@facetframer.com)'"
    message "'  @facetframer'"
    message "'  http://www.facetframer.com/'"
    message

    message "For more about willghatch"
    message "'    http://willghatch.net/blog/'"
}

close-shell () {
tmux send-keys -t test.1 'exit
'
}

sleep 1;
play-banner
play-attribution
play-introduction-text
spawn-command-window
play-introduction-snippet
play-keybindings
play-benefits
play-examples
close-shell
play-credits
sleep 4;
tmux -S /tmp/mux kill-server