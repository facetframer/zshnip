# Zshnip

A snippet system for [zsh](http://zsh.sourceforge.net/). Create new [snippets as you go](https://facetframer.com/dayg).

## Presentation

[![asciicast](https://asciinema.org/a/clqz3z43ct1cq7l1i2ocmtvdd.png)](https://asciinema.org/a/clqz3z43ct1cq7l1i2ocmtvdd)
[Gallery of features](GALLERY.md) (animated gifs)

# Attribution

This is an extended version of William G Hatch's (willghatch@gmail.com)
[original library](https://github.com/willghatch/zsh-snippets) that was influenced by code on various forums.
The define-as-you-go features were added by facet@facetframer.com.

# Similar projects

https://github.com/1ambda/zsh-snippets is another extension of willghatch's library.

# Installation

Using *zplug*

```
    source /usr/share/zplug/init.zsh
    zplug facetframer/zshnip
    zplug install
    zplug load
```

Using *zgen*

```
    zgen load facetframer/zshnip
    zgen init
```

Raw installation

```
    git clone https://github.com/facetframer/zshnip.git
    echo "source zshnip/zshnip.plugin.zsh" >> ~/.zshrc
```


Manually create key-bindings for defining snippets

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

# Likely Questions: Can't you just this with aliases?

Certainly, you can even supports pipes etc in your aliases using global aliases (`alias -g g='| grep '`),
you could also perhaps write a wrapper about `alias` to ensure that it saves to your zshrc, and
potentially use something like https://github.com/jarmo/expand-aliases-oh-my-zsh to expand them.

Using snippets have some benefits

 - You can verify that snippets expand to what you want before running them (useful if you have a *lot* of snippets)
 - The define-as-you-go features have various [benefits](define-as-you-go.md).

# Testing

The code for generating the [feature gallery](GALLERY.md) also performs consistency testing.
Combining testing and generation of documentation like this has various benefits (see *doctest*).
To run these tests run `animation/record-gallery.sh`

# License

LGPLv3 (see [LICENSE](LICENSE) for details.)

Copyleft licenses can be controversial.
This project feels like more of application than a library so a copyleft license seems like a good choice.
If there is a compelling reasons to place this under a more permissive license this would not be difficult.
