#!/bin/zsh

zstyle :compinstall filename "$HOME/.zsh/01-zsh-main.zsh"
autoload -Uz compinit && compinit

export GREP_OPTIONS=''
export PATH=$HOME/bin:/usr/local/bin:$PATH
export EDITOR=vim
export VISUAL=vim

autoload -Uz colors && colors

autoload -Uz autocd
setopt autocd
setopt extendedglob
zstyle ':completion:*' menu selectA

# Misc bindings
bindkey -e

# [Ctrl-r] - backwards incremental search
bindkey '^r' history-incremental-search-backward

# [PageUp] - Up a line of history
if [[ "${terminfo[kpp]}" != "" ]]; then
  bindkey "${terminfo[kpp]}" up-line-or-history
fi

# [PageDown] - Down a line of history
if [[ "${terminfo[knp]}" != "" ]]; then
  bindkey "${terminfo[knp]}" down-line-or-history
fi

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Home] - Go to beginning of line
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line
fi

# [End] - Go to end of line
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line
fi

# [Space] - do history expansion
bindkey ' ' magic-space

# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5C' forward-word

# [Ctrl-LeftArrow] - move backward one word
bindkey '^[[1;5D' backward-word

# [Shift-Tab] - move through the completion menu backwards
if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi
