#!/bin/zsh

bindkey -e

zstyle :compinstall filename "$HOME/.zsh/01-zsh-main.zsh"

autoload -Uz compinit && compinit

export GREP_OPTIONS=''
export PATH=$HOME/bin:/usr/local/bin:$PATH
export EDITOR=vim
export VISUAL=vim

autoload -Uz colors && colors

autoload -U autocd
setopt autocd
setopt extendedglob
zstyle ':completion:*' menu select
