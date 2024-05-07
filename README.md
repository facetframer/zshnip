# Zshnip
A snippet system for [zsh](http://zsh.sourceforge.net/). Create new [snippets as you go](https://facetframer.com/dayg).

| Features | zsh alias | global alias | zsh-snippets | zshnip |
| --- | --- | --- | --- | --- |
| Snippets automatically saved | :x: | :x: | :x: | :white_check_mark: |
| Forgot snippet name 😧 | :grimacing: | :grimacing: | :grimacing: | :relaxed: (recreate with new name because it's probably easier to remember) |
| Remembers cursor position | :x: | :x: | :x: | :white_check_mark: (useful for commands with pipes "|") |
| How snippets are defined |  ⏲️ (editor) |  ⏲️ (editor) |  ⏲️ (editor) | :relaxed: at shell itself |
| Tweak command before run | :x: | :x: | :x: | ✅ |
| Create snippets while creating snippets | :x: | :x: | :x: | ✅ |

## Concise introductions
This [gallery of features](GALLERY.md) provides animated GIFs that document many features.

[This 20 second animated gif](https://github.com/facetframer/zshnip/blob/master/animation/gallery-gifs/gallery-define.gif) gives a good summary of why you might want to use zshnip.

[![Youtube introduction](https://img.youtube.com/vi/6bHHKTBNhb0/0.jpg)](https://www.youtube.com/watch?v=6bHHKTBNhb0)


# Attribution
This is an extended version of William G Hatch's (willghatch@gmail.com)
[original library](https://github.com/willghatch/zsh-snippets) that was influenced by code on forums.
The define-as-you-go features were added by facet@facetframer.com.

Code for rendering the presentation to MP4 is taken from [asciinema2gif](https://github.com/tav/asciinema2gif) by tav (public domain).




# Installation
## Step 1: Get the code
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
    cd ~
    git clone https://github.com/facetframer/zshnip.git
    echo "source zshnip/zshnip.zsh" >> ~/.zshrc
```

## Step 2: Create some key-bindings

Manually create key-bindings for defining snippets.
(you can use different bindings if desired)

```
bindkey '\ej' zshnip-expand-or-edit # Alt-J
bindkey '\ee' zshnip-edit-and-expand # Alt-E
```

# Usage

There is a concise walk-through of using zshnip in [this section of the presentation](https://www.youtube.com/watch?v=6bHHKTBNhb0&t=35).

After having installed zshnip and defined key-bindings (see the section above):

- Type your snippet alias (e.g. `gs`)
- Run `zshnip-expand-or-edit` with `Alt-J` (or your own key-binding)
- A prompt will appear within your shell to define your snippet
- Type your snippet (e.g. `git status`) and press `ENTER`.
- Your snippet will have expanded.
- After this, when you press `Alt-J` after your snippet alias (e.g. `gs`) this expansion will be used.


# Motivation

Defining snippets can be problematic:

1. Learning other people's snippets is boring
1. One only knows what snippets you want while you are carrying out a task, not later.
1. Going to an editor to define a snippet can hijack another task.

# Can't you just use aliases?

Certainly, you can even supports pipes etc in your aliases using global aliases (`alias -g g='| grep '`).
You could also write a wrapper about `alias` to persist aliases and use something like
https://github.com/jarmo/expand-aliases-oh-my-zsh to expand them.

Using snippets have some benefits

 - You can verify that snippets expand to what you want before running them (useful if you have a *lot* of snippets)
 - The define-as-you-go features have [various benefits](define-as-you-go.md).

# Some compelling use cases

Here is a list of the snippets the maintainer uses on a regular basis.
These are not built-in, and you might want to phrase them differently, but they could act as inspiration.

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
