# Repository Notes

- Each folder mirrors destination paths relative to `$HOME`; `install.sh` copies
  only the folders named on the command line. No arguments is an error.
- Keep `install.sh` simple: one generic copy path for every folder, and
  package-manager commands only under `platform` (`install_ubuntu` / `install_macos`).
  Folders contain only dotfiles; no per-folder install scripts.
- Only dot-entries at a folder's top level are copied. Non-dot files there
  (e.g. `nvim/AGENTS.md`) are repo-only docs; read them before editing that folder.
- Preserve unrelated destination files: never use `rsync --delete`.
- `.backup/` can contain private configuration. Never stage or publish it.
- Test installs only with a temporary `HOME`; never install into the actual home
  directory or run real package managers during verification.
