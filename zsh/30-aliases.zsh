#!/bin/zsh

# Shortcuts
alias h="history"
alias j="jobs"

# Git
alias g="git"
alias gc="git commit"
alias ga="git add"
alias gca="git commit --amend"
alias gpf='until git push --force-with-lease; do echo "retrying..."; done'
alias gr="git reset"
# Git rebase green & force push
alias grgp="git fetch origin green && git rebase origin/green && gpf"

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

# Prefer nvim if it is installed
if [[ -e "$(which nvim)" ]]; then
    alias vim="nvim"
    alias vimdiff='nvimdiff'
fi

# copy to clipboard via osc52 escape sequence
copy() {
  printf '\033]52;c;%s\a' "$(base64 </dev/stdin | tr -d '\n')" >/dev/tty
}

# vim
alias v='vim'
alias vf='vim $(fzf --height 40% --border --reverse)'
