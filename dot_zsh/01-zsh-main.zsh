#!/bin/zsh

bindkey -e

zstyle :compinstall filename "$HOME/.zsh/01-zsh-main.zsh"
autoload -Uz compinit && compinit

autoload -Uz colors && colors

autoload -Uz autocd
setopt autocd
setopt extendedglob
zstyle ':completion:*' menu selectA

export GREP_OPTIONS=''
export PATH=$HOME/.bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export EDITOR=nvim
export VISUAL=nvim
