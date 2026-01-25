# Global Agent Instructions

This is the global AGENTS.md for all projects. Project-specific AGENTS.md files take precedence over this one.

## Git Operations

- **Never** automatically perform git "write" operations unless explicitly asked:
  - push, pull, checkout, commit, rebase, cherry-pick, merge, reset, etc.
- Read-only git operations (status, log, diff, branch --list) are fine without asking

## Commit Message Convention

When asked to make a commit, use this format:

```
<change_type>: short description
```

- Keep it concise - generally no body/description needed
- Use lowercase for the change type
- Common change types: the affected tool, config, or area (e.g., `zsh`, `tmux`, `bin`, `README`, `gitconfig`)

### Examples

```
zsh: update `gca` alias to include `no-edit` flag
chezmoi: add `.chezmoi.toml.tmpl` template for config init
tmux: swap default terminal to `xterm-256color` to fix colors
zsh: add `.local/bin` to PATH
tmux: explicitly set `default-shell`
i3: fix up status bar after moving bin folder
bin: make scripts executable
gitconfig: template out email config option
```
