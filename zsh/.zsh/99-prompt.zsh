#!/bin/zsh

autoload -Uz promptinit
promptinit
setopt promptsubst

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`')'
}

function ssh_info() {
  if [[ -n $SSH_CONNECTION || -n $SSH_TTY ]]; then
    echo " %{$fg_bold[cyan]%}(ssh)%{$reset_color%}"
  fi
}

function git_prompt() {
  local ref="$(git rev-parse --symbolic-full-name --abbrev-ref HEAD 2>/dev/null)"
  if [ -n "$ref" ]; then
    echo " on %{$fg_bold[magenta]%}${ref#refs/heads/}%{$reset_color%}"
  fi
}

PROMPT='%{$fg_bold[red]%}%n%{$reset_color%} at %{$fg_bold[yellow]%}$(hostname)%{$reset_color%}$(ssh_info) in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt)
$(virtualenv_info)%(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%} )$ '
RPROMPT=''
