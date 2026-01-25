---
name: git-commit
description: Stage and commit changes following project commit message conventions
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: git
---

## Purpose

Guide safe staging and committing of changes with consistent commit message formatting.

## Commit Message Convention

Use this format:

```
<change_type>: short description
```

- Keep it concise - generally no body/description needed
- Use lowercase for the change type
- Common change types: the affected tool, config, or area (e.g., `zsh`, `tmux`, `bin`, `readme`, `gitconfig`, `opencode`)

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
opencode: add /commit skill and command
```

## Staging Safety

Before staging, check for files that should NEVER be committed:

- `.env`, `.env.*` (environment secrets) — **except** `.env.example`, `.env.sample`
- `.envrc` (direnv secrets)
- `*.pem`, `*.key`, `*.p12` (private keys/certs)
- `*id_rsa*`, `*id_ed25519*` (SSH keys)
- `credentials*`, `secrets*`, `*.kdbx` (credential stores)
- `*.pyc`, `__pycache__/`, `node_modules/`, `*.o`, `*.a` (build artifacts)
- `.DS_Store`, `Thumbs.db` (OS junk)

If any such files appear in `git status`, warn the user and do NOT stage them. List them explicitly.
If anything is of major concern, terminate **IMMEDIATELY** (including a message detailing _why_).

## Workflow

1. Run `git status --porcelain=v1 -uall` to see all changes
2. Run `git diff` and `git diff --staged` to understand unstaged and staged changes
3. Identify any "bad files" from the list above - warn and exclude them
4. Stage safe files with `git add <path>` (prefer explicit paths over `git add -A`)
5. Confirm staged set with `git diff --staged --stat`
6. Draft or use provided commit message following the convention above
7. Run `git commit -m "<message>"`
8. Verify with `git status`

## When to Use

Use this skill when committing changes to ensure:
- No secrets or sensitive files are accidentally committed
- Commit messages follow the project convention
- All relevant files are staged
