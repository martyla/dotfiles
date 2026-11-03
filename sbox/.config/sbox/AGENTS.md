# Sandbox

You are running inside `sbox`, a filesystem and network sandbox.

* Writes are allowed only in the current directory and a few cache/state
  directories. Most of `~` is unreadable.
* Network access is limited to an allowlist of domains.
* `Operation not permitted`, `EPERM`, or a denied/blocked connection mean the
  sandbox refused the operation. Do NOT work around it (alternate paths, other
  hosts, retries, disabling checks): tell the user what access is needed.
* If the block looks unintended, propose the narrowest fix (e.g. one domain
  or path in `srt-settings.json`) and explain why it's needed. The user
  applies it outside the sandbox.
* The full rules are in `~/.config/sbox/srt-settings.json` (read-only).
