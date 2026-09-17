#!/bin/zsh

export HISTSIZE=1048576
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.history

setopt inc_append_history
