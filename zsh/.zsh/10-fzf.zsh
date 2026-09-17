if [[ -x "$(command -v fd)" ]]; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git 2>/dev/null'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git 2>/dev/null'
elif [[ -x "$(command -v rg)" ]]; then
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" 2>/dev/null'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Older distro versions do not support `fzf --zsh`.
if [[ -x "$(command -v fzf)" ]] && fzf_init=$(fzf --zsh 2>/dev/null); then
    source <(printf '%s\n' "$fzf_init")
fi
unset fzf_init
