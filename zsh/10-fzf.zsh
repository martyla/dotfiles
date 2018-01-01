if [[ -x "$(command -v ag)" ]]; then
    export FZF_DEFAULT_COMMAND='ag --depth 100 --hidden -U --ignore .git -g "" 2>/dev/null'
elif [[ -x "$(command -v rg)" ]]; then
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" 2>/dev/null'
fi
