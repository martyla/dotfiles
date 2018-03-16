#!/usr/bin/env bash
#
# Generates a minimal vimrc (no plugins, bundles, etc)
# For use on external servers etc.
#
set -eu

main() {
  local files=(
    ./20-*.vim
    ./bundle/repos/github.com/chriskempson/base16-vim/colors/base16-default-dark.vim
  )

  cat "${files[@]}" > minimal_vimrc
}

main
