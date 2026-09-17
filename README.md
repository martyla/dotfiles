# Dotfiles

Each folder mirrors `$HOME`. Pick what you want based on top level folder.

```sh
./install.sh platform zsh nvim tmux git bin agents pi
./install.sh i3 conky xinit alacritty   # linux desktop
```

`platform` installs the CLI tools (apt on Linux, brew on macOS) plus Pi via npm.
Everything else just copies files into `$HOME`. Nothing is symlinked and
unrelated files are left alone.

Files that would be overwritten with different content are first saved to
`.backup/<timestamp>/`, mirroring their path under `$HOME`. `.backup/` is gitignored.
