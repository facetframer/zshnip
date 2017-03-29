# Zshnip

A snippet system for [zsh](http://zsh.sourceforge.net/). Create new snippets as you go.

[![asciicast](https://asciinema.org/a/3fz3tnk2turajry6m8rpyq4j4.png)](https://asciinema.org/a/3fz3tnk2turajry6m8rpyq4j4)

# Attribution

This is an extended version of William G Hatch (willghatch@gmail.com)
[original library](https://github.com/willghatch/zsh-snippets) that was influenced by code on various forums.
The define-as-you-go features were added by facet@facetframer.com.

# Similar projects

https://github.com/1ambda/zsh-snippets is another extension of willghatch's library.

# Installation

Using zplug

```
    source /usr/share/zplug/init.zsh
    zplug facetframer/zshnip
    zplug install
    zplug load
```

Using zgen

```
    zgen load facetframer/zshnip
    zgen init
```

Raw installation

```
    git clone https://github.com/facetframer/zshnip.git
    echo "source zship/zshnip.plugin.zsh" >> ~/.zshrc
```


Manually create keybindings for defining snippets

```
bindkey '\ej' zshnip-expand-or-edit
bindkey '\ee' zshnip-edit-and-expand
```

# Usage

Type your snippet alias, run `M-x zshnip-expand-or-edit`, type what your new snippet should be.
After this your snippet is defined and next time you run `zshnip-expand-or-edit` it will use your definition.

# Motivation

Defining snippets can be problematic:

1. Learning other people's snippets is boring
1. You only know what snippets you want while you are typing them, not later
1. Going to an editor to define a snippet can interrupt you

# License

LGPLv3 see `LICENSE` for details.

Copyleft licenses can be controversial.
This project feels like more of application than a library so a copyleft license seems like a good choice.
If there is a compelling reasons to place this under a more permissive license this would not be difficult.
