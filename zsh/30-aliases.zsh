#!/bin/zsh

# Shortcuts
alias h="history"
alias j="jobs"

# Git
alias g="git"
alias gc="git commit"
alias ga="git add"
alias gr="git reset"

# Use color output for ls/grep
if ls --help 2>&1 | grep -q -- --color
then
    # GNU Linux
    alias ls="ls --color=auto -F"
else
    # OSX
    alias ls="ls -GFh"
fi

alias grep="grep --color=auto"

# Allow aliases to be sudo'd
alias sudo='sudo '

# Get remote ip
alias rip="curl http://icanhazip.com"

# Reload shell (invoke as login shell)
alias reload="exec $SHELL -l"

alias cal='watch -c -n 180 gcalcli agenda today --military --defaultCalendar "mgroen@freelancer.com"'

# Prefer nvim if it is installed
if [[ -e "$(which nvim)" ]]; then
    alias vim="nvim"
fi

# vim
alias v='vim'
alias vf='vim $(fzf --height 40% --border --reverse)'
