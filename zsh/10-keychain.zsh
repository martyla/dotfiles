#!/bin/zsh

if [[ $SSH_CONNECTION == "" ]]; then
  which keychain &>/dev/null
  if [ $? -eq 0 ]; then
    eval `keychain --inherit any --eval --agents ssh`
  fi
fi
