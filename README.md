# Zshnip

A snippet system for [zsh](http://zsh.sourceforge.net/). Create new [snippets as you go](https://facetframer.com/dayg).

## Presentation

[![Youtube introduction](https://img.youtube.com/vi/2lkisDF__qo/0.jpg)](https://www.youtube.com/watch?v=2lkisDF__qo)

[Gallery of features](GALLERY.md) (animated gifs)

# Attribution

This is an extended version of William G Hatch's (willghatch@gmail.com)
[original library](https://github.com/willghatch/zsh-snippets) that was influenced by code on various forums.
The define-as-you-go features were added by facet@facetframer.com.

Code for rendering the presentation to mp4 is taken for [asciinema2gif](https://github.com/tav/asciinema2gif) by tav (public domain).

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

Type your snippet alias, run `M-x zshnip-expand-or-edit`, then type what your new snippet should be.
After this your snippet is defined and next time you run `zshnip-expand-or-edit` it will use your new definition.

# Motivation

Defining snippets can be problematic:

1. Learning other people's snippets is boring
1. One only knows what snippets you want while you are carrying out a task, not later.
1. Going to an editor to define a snippet can hijack another task.

# Can't you just use aliases?

Certainly, you can even supports pipes etc in your aliases using global aliases (`alias -g g='| grep '`).
You could also perhaps write a wrapper about `alias` to persist aliases and use something like
https://github.com/jarmo/expand-aliases-oh-my-zsh to expand them.

Using snippets have some benefits

 - You can verify that snippets expand to what you want before running them (useful if you have a *lot* of snippets)
 - The define-as-you-go features have [various benefits](define-as-you-go.md).

# Some compelling use cases

```
gs -> git status
mh -> --help
mf -> --force
g -> | grep -i
gv -> | grep -v
sda -> sed -n '//,$ p'
gap -> git add -p
o -> $(!!)
lm1 -> | tail -n 1
xarm -> xargs -n 1 kill
xarmp -> xargs -p -n 1 kill
sso -> | grep -o ''
sss -> | grep -P '^'
w1 -> | awk '{ print $1 }'
wm1 -> | rev | awk ' { print $1 }'
si -> sudo apt-get install
sa -> sudo !!
ag -> !! | grep
```


# Testing

The code for generating the [feature gallery](GALLERY.md) also performs consistency testing.
Combining testing and generation of documentation like this has various benefits (see *doctest*).
To run these tests run `animation/record-gallery.sh`

# Similar projects

- https://github.com/1ambda/zsh-snippets is another extension of willghatch's library.
- I am an extensive user of [yasnippet](https://github.com/joaotavora/yasnippet) in emacs. This will have without doubt influenced features in this project.

# License

LGPLv3 (see [LICENSE](LICENSE) for details.)

Copyleft licenses can be controversial.
This project feels like more of application than a library so a copyleft license seems like a good choice.
If there is a compelling reasons to place this under a more permissive license this would not be difficult.
