#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"
BACKUP_DIR="$PWD/.backup/$(date '+%Y-%m-%d_%H-%M-%S')"

copy() (
    shopt -s dotglob
    mkdir -p "$2"
    # Copy entries individually so rsync leaves the destination root's permissions alone.
    rsync -aLc --backup --backup-dir="$BACKUP_DIR" --exclude='.git' --exclude='.DS_Store' "$1"/* "$2"/
)

copy_all() {
    local dst=$1; shift
    for pkg in "$@"; do copy "$pkg" "$dst"; done
}

install_ubuntu() {
    sudo apt-get update
    sudo apt-get install -y build-essential curl fd-find fzf gh git git-lfs keychain \
        neovim nodejs npm ripgrep rsync tmux tree-sitter-cli zsh
}

install_macos() {
    brew update
    brew install fd fzf gh git git-lfs keychain neovim node ripgrep rsync tmux tree-sitter-cli zsh
}

install_platform() {
    case "$(uname -s)" in
        Linux)  install_ubuntu ;;
        Darwin) install_macos ;;
        *)      echo "Unsupported OS: $(uname -s)"; exit 1 ;;
    esac
    npm install -g --ignore-scripts @earendil-works/pi-coding-agent
}

main() {
    if [[ $# -eq 0 ]]; then
        echo "usage: ./install.sh <folder>... e.g. ./install.sh platform zsh nvim tmux git bin agents pi"
        exit 1
    fi

    for pkg in "$@"; do
        if [[ "$pkg" != platform && ! ( "$pkg" =~ ^[a-z0-9]+$ && -d "$pkg" ) ]]; then
            echo "unknown folder: $pkg"
            exit 1
        fi
    done

    for pkg in "$@"; do
        echo "installing $pkg"
        if [[ "$pkg" == platform ]]; then
            install_platform
        else
            copy_all "$HOME" "$pkg"
        fi
    done

    if [[ -d "$BACKUP_DIR" ]]; then
        echo "backups saved to $BACKUP_DIR"
    fi
}

main "$@"
