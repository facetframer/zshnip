# Zshnip

A snippet system for [zsh](http://zsh.sourceforge.net/). Create new snippets as you go.

# Attribution

This is an extended version of William G Hatch (willghatch@gmail.com)
[original library](https://github.com/willghatch/zsh-snippets) that was influenced by code on various forums.
The define as you go features were added by facet@facetframer.com.

# Prior work and similar projects

https://github.com/1ambda/zsh-snippets is another extension of willghatch's library.

# Installation

Using zplug

```
    zplug facetframer/zshnip
```

Using zgen

```
    zgen load facetframer/zshnip
```

Raw installation

```
    git clone https://github.com/facetframer/zshnip.git
    echo "source zship/zshnip.plugin.zsh" >> ~/.zshrc
```


Manually create keybindings for defining snippets

bindkey '\ej' snippet-expand-or-edit
bindkey '\ee' snippet-edit-and-expand


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
1. You only know what snippets you want while you are typing them, not later
1. Going to an editor to define a snippet can interrupt you

For this reason we have the `snippet-expand-or-edit` command. This allows you
define snippets as you go with minimal extra work and interruption by:

1. Opening an editor in the current terminal
2. Saving the snippet to ~/.zsh-snippets when you exit
3. Loading the snippet and immediately expanding it

Zsh doesn't like opening a curses editor while expanding
things, so we work around this using tmux. This adds a few
dependencies

1. The shell must be running within tmux
1. The shell process must have access to this tmux (e.g not tmux wrapping ssh)

Additionally, the function `snippet-edit-and-expand` can quickly change an existing
snippet. (When called on an empty line, this edits the last expanded snippet)

One can also define new snippets within zsh itself (in a similar manner to
zsh's `push-line` command). To do this set `snippet_edit_func` to `snippet-shell-edit`
after loading this plugin.

```
source snippets.plugin.zsh
snippet_edit_func=snippet-shell-edit
```

This lets you use zsh completion while defining your snippet.


License
-------

I've seen parts of this code all over the web, so I assume it's fair game.  All my contributions I dedicate to the public domain.
