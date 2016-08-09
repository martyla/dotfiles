#/bin/sh

if [[ -e $HOME/.xinitrc.local ]]; then
    source $HOME/.xinitrc.local
fi

exec i3
