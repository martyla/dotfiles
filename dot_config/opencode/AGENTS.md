# Global Agent Instructions

This is the global AGENTS.md for all projects. Project-specific AGENTS.md files take precedence over this one.

## Git Operations

- **Never** automatically perform git "write" operations unless explicitly asked:
  - push, pull, checkout, commit, rebase, cherry-pick, merge, reset, etc.
- Read-only git operations (status, log, diff, branch --list) are fine without asking
- When the user explicitly asks to commit, load the `git-commit` skill for conventions and safety rules
