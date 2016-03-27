Install
-------

For the lazy:

    git clone https://github.com/willghatch/zsh-snippets.git
    echo "source zsh-snippets/snippets.plugin.zsh" >> ~/.zshrc

Better, use [zgen](https://github.com/tarjoilija/zgen) or antigen.  Here is how to do it with zgen:

    zgen load willghatch/zsh-snippets


The Magic
---------

Expand text anywhere on the command line, like aliases.

    ps aux tg! # ! represents cursor position
    # M-x snippet-expand, or hopefully you bind it to a key
    ps aux | grep! # ! is your new cursor position

Add snippets

    snippet-add d "/my/long/directory/or/something like that"
    # then you can expand d to... that long thing

List snippets

    help-list-snippets # pulls up help in a your pager
    # or
    # M-x run-help-list-snippets -- does the same thing

This snippet stuff has been floating around in a few different forms and names.  I think the first version was from http://zshwiki.org/home/examples/zleiab.  My version adds some (in my opinion) handy interface functions, and packages it in a plugin for easy use with antigen.

Defining snippets as you go
---------------------------

Requirements: vim, tmux, you to be using tmux

Defining snippets can be problematic:

1. Learning other people's snippets is boring
1. You tend to know what snippet you want only when you are typing it
1. Going to an editor to define a snippet can interrupt you

For this reason we have the `snippet-expand-or-edit` command. This allows you
define snippets as you go with minimal extra work and interruption by:

1. Opening an editor in the current terminal
2. Saving the snippet to ~/.zsh-snippets when exit
3. Loading the snippet and immediately expanding it

Zsh doesn't like opening a curses editor while expanding
things, so we work around this using tmux. This adds a few
dependencies

1. The shell mush be running within tmux
1. The shell process must have access to this tmux (e.g not tmux wrapping ssh)

License
-------

I've seen parts of this code all over the web, so I assume it's fair game.  All my contributions I dedicate to the public domain.
