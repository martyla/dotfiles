#!/bin/zsh

autoload -Uz promptinit
promptinit
setopt promptsubst

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`')'
}

setopt promptsubst
PROMPT='%{$fg_bold[red]%}%n%{$reset_color%} at %{$fg_bold[yellow]%}$(hostname)%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}
$(virtualenv_info)%(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%} )$ '
RPROMPT=''
