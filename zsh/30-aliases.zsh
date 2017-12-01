#!/bin/zsh

# Shortcuts
alias g="git"
alias h="history"
alias j="jobs"

# Use color output for ls/grep
alias ls="ls -GFh"
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
