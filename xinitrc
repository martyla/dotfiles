#!/bin/sh

if [[ -e $HOME/.xinitrc.local ]]; then
    source $HOME/.xinitrc.local
fi

# Fix backspace capslock repeat
setxkbmap -option caps:backspace
setxkbmap -option shift:both_capslock
xmodmap -e "clear Lock"

# Keyboard repeat rate
xset r rate 300 50

# Merge Xresources
xrdb -merge $HOME/.Xresources

exec i3
