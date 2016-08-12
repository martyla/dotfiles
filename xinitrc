#/bin/sh

if [[ -e $HOME/.xinitrc.local ]]; then
    source $HOME/.xinitrc.local
fi

# Fix backspace capslock repeat
setxkbmap -option caps:backspace
setxkbmap -option shift:both_capslock
xmodmap -e "clear Lock"

exec i3
