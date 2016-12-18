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

# Set monitor sleep
xset s blank
xset s 300 # blank at 5 min
xset dpms 0 360 600 # suspend at 6 min, off at 10 min

exec i3
