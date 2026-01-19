# Dotfiles

Personal configuration files managed by `chezmoi`.

## How to run

Set variables in your chezmoi config under `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
    profile = "home" # required (values: home, work)
    include_alacritty = true # optional (default: false)
    include_i3 = true # optional (default: false)
    include_conky = true # optional (default: false)
    include_xinitrc = true # optional (default: false)
```

Apply the config changes:

```sh
chezmoi apply -v
```

Or:
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply martyla
```
