# CustomEmacs
CustomEmacs configuration is a set of parameters, keyboard shortcuts, and extension modules that allow the user to customize the appearance, behavior, and features of the Emacs text editor.

## Features
- ctrl + p: previous line (or previous command in history)
- ctrl + n: next line
- ctrl + f: forward (move cursor to the right)
- ctrl + b: backward (move cursor to the left)
- ctrl + d: delete
- ctrl + s: search
- ctrl + space: start marking for copy
- ctrl + e: end of line
- ctrl + a: beginning of line
- ctrl + a, ctrl + space, ctrl + e: select line
- ctrl + k: kill the line and put it in clipboard
- ctrl + y: paste
- Meta + w: copy without killing the line; still use ctrl+y to paste (Meta key is usually the Windows key)
- ctrl + 2: split window horizontally
- ctrl + 3: split window vertically
- ctrl + x, o: switch between windows
- esc esc: close all other windows and stay in the current one (others remain open and can be re-opened)
- ctrl + x, ctrl + s: save
- ctrl + x, ctrl + c: exit Emacs
- ctrl + v: scroll down
- meta + v: scroll up

## Installation

You create a themes directory in your .emacs.d

```mkdir ~/.emacs.d/themes```

You copy current-colors.el into it

```cp current-colors.el ~/.emacs.d/themes```

Copy ultra-light-init.el and eonos-theme.el into your .emacs.d

```cp ultra-light-init.el eonos-theme.el ~/.emacs.d/```

In your .bashrc you add the following line:

```alias em="emacs -nw -q -l ~/.emacs.d/ultra-light-init.el"```

Restart your bashrc if you want to avoid closing and reopening your terminal:

```source .bashrc```

So to open a c++ file, you do:

```em filename.cpp```


## Requirement

You must have emacs installed

dnf :
```sudo dnf update```
```sudo dnf install emacs```

apt :
```sudo apt update```
```sudo apt install emacs```
