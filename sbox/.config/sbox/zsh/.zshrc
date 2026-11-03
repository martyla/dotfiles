#!/bin/zsh

# Mirrors ~/.zshrc minus host-only config: ssh keychain and local overrides.
for config in $HOME/.zsh/*.zsh; do
  case ${config:t} in
    10-keychain.zsh|99-zsh-local.zsh) ;;
    *) source $config ;;
  esac
done

HISTFILE=$XDG_STATE_HOME/zsh_history
PROMPT="%{$fg_bold[blue]%}(sbox)%{$reset_color%} $PROMPT"

alias pi='pi --append-system-prompt ~/.config/sbox/AGENTS.md'
