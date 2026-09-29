#!/bin/zsh

if [[ $SSH_CONNECTION == "" ]] && (( $+commands[keychain] )); then
  keychain_args=(--eval --quiet)
  # keychain < 3 needs --agents to avoid also starting gpg-agent; 3.x deprecates it.
  if [[ $(keychain --version 2>&1) =~ 'keychain ([0-9]+)\.' ]] && (( match[1] < 3 )); then
    keychain_args+=(--agents ssh)
  fi
  eval $(keychain $keychain_args id_rsa)
  unset keychain_args
fi
