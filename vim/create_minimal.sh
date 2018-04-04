#!/usr/bin/env bash
#
# Generates a minimal vimrc (no plugins, bundles, etc)
# For use on external servers etc.
#
set -eu

main() {
  local files=(
    ./20-*.vim
    ./bundle/repos/github.com/chriskempson/base16-vim/colors/base16-monokai.vim
  )

  # HACK: inlining base16-monokai theme so need to exclude setting the color_name
  cat "${files[@]}" \
    | grep -v 'let g:colors_name' \
    >minimal_vimrc
}

main
