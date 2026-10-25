# Neovim config

- The config lives in `.config/nvim/`. This file and `README.html` are
  repo-only: `install.sh` copies only dot-entries, so they never reach `$HOME`.
- `README.html` is an interactive diagram of the config: a single file
  with no dependencies. **Update it in the same change as any config change**
  (plugins, options, keymaps, LSP servers, Treesitter parsers, load order,
  or what `install.sh platform` installs for nvim).

## Updating README.html

1. Edit the data in the `<script>` block to match the config:
   - `NODES`: one box per file, plugin, or external tool. `what` describes
     behaviour, `keys` lists mappings (`L` is the leader `,`), `src` names a
     `SOURCES` key, `line` holds an inline lazy spec. Columns: 0 entry,
     1 core config, 2 inline plugins, 3 `lua/plugins/*`, 4 deps/tools.
   - `EDGES`: `load`, `dep`, or `link` (cross-links: an option or key that
     exists for another component).
   - `SCENARIOS`: walk-through steps. `KEYGROUPS`: Keymaps tab.
   - Counts in text (plugins, parsers, servers) and the "At a glance" list in
     `renderEmpty()`.
2. Regenerate the embedded source snapshots (from the repo root):

   ```sh
   python3 - <<'EOF'
   import json, pathlib, re
   cfg = pathlib.Path('nvim/.config/nvim')
   src = {str(p.relative_to(cfg)): p.read_text() for p in sorted(cfg.rglob('*'))
          if p.is_file() and p.suffix in ('.lua', '.json')}
   src['install.sh'] = pathlib.Path('install.sh').read_text()
   html = pathlib.Path('nvim/README.html')
   block = 'const SOURCES = ' + json.dumps(src, ensure_ascii=False).replace('</', '<\\/') + ';'
   html.write_text(re.sub(r'(// BEGIN SOURCES[^\n]*\n).*?(\n// END SOURCES)',
                          lambda m: m[1] + block + m[2], html.read_text(), count=1, flags=re.S))
   EOF
   ```

3. Check it in a browser. Playwright blocks `file://`, so serve it with
   `python3 -m http.server` from `nvim/`. Look for console errors, then click
   a few nodes and run a walk-through.

## Verifying config changes

- Never install into the real `~/.config/nvim` or trigger Mason/lazy installs
  in the real data dir. To check that Lua files parse, use
  `nvim --headless --clean -l` with `loadfile(...)`.
