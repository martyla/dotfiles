#!/usr/bin/env bash

set -eu
set -o pipefail

main() {
    if [ "$(whoami)" != "coder" ]; then
        echo "Currently only supporting coder workspace"
        exit 1
    fi

    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg tmux neovim fzf

    local script_dir="$(dirname "$(realpath "$0")")"

    cp "$script_dir/editorconfig" "$HOME/.editorconfig"
    cp "$script_dir/tmux.conf" "$HOME/.tmux.conf"
    cp "$script_dir/zshrc" "$HOME/.zshrc"
    cp -r "$script_dir/zsh" "$HOME/.zsh"
    cp -r "$script_dir/nvim" "$HOME/.config/nvim"

    mkdir -p "$HOME/bin"
    cp "$script_dir/bin/tmux-sessionizer" "$HOME/bin/tmux-sessionizer"
    sed -i 's|~/canva|~/work/canva|' "$HOME/bin/tmux-sessionizer"

    cp "$script_dir/gitconfig" "$HOME/.gitconfig"
    sed -i 's/martin@martinjgroen.com/martin@canva.com/' "$HOME/.gitconfig"
    cp "$script_dir/gitignore_global" "$HOME/.gitignore_global"

    chsh -s /bin/zsh
}

main "$@"
