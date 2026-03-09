# Repository Notes

## Checking chezmoi template changes

- Prefer rendering a template before changing it so you can see the target output with your current local chezmoi data.
- Render a managed file with current config data using `chezmoi cat --source-path <source-file>`, for example `chezmoi cat --source-path dot_gitconfig.tmpl`.
- Diff the rendered target against the current destination state with `chezmoi diff --source-path <source-file>`.
- When you need to test a different data shape without changing local config, use `--override-data` or `--override-data-file`, for example `chezmoi cat --source-path dot_gitconfig.tmpl --override-data '{"profile":"work","email":"name@example.com"}'`.
- When changing `.chezmoi.toml.tmpl`, render it in init mode with simulated prompts, for example `chezmoi execute-template --init --promptString profile=home --file .chezmoi.toml.tmpl`.
- If you need to exercise multiple profiles or config combinations, rerun the same `chezmoi cat`, `chezmoi diff`, or `chezmoi execute-template` command with different `--override-data`, `--override-data-file`, or `--promptString` values.
