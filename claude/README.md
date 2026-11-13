# Claude Code

`install.sh` links these into `~/.claude/`:

| Repo file         | Linked to                  | Contents                                   |
| ----------------- | -------------------------- | ------------------------------------------ |
| `settings.json`   | `~/.claude/settings.json`  | User settings for every project            |
| `CLAUDE.md`       | `~/.claude/CLAUDE.md`      | Instructions loaded into every session     |

Claude Code installs separately: `curl -fsSL https://claude.ai/install.sh | bash`.

## Settings

- `statusLine`: prints the session's working directory (full path, in bold)
  below the prompt. It reads the JSON Claude Code passes on stdin with `jq`, which
  ships with macOS 15 and later at `/usr/bin/jq`.
- `theme: light`: matches the light color scheme used across the repo.
- `permissions.defaultMode: auto`, `tui: fullscreen`, and the rest are
  preferences set through `/config`.

Changes made with `/config` or `/statusline` are written through the symlink,
so they show up in `git diff` here. Review them before committing. If
`~/.claude/settings.json` ever turns into a regular file instead of a link,
re-run `install.sh`: it moves the file to `settings.json.backup-<timestamp>`
and relinks, and you can merge any wanted changes back by hand.

## What stays out of the repo

This repo is public. Keep these machine-local:

- API keys and tokens. Do not use the `env` block in `settings.json` for
  them. Export them from `~/.zshrc` or read them from the Keychain (see
  `install.sh`'s closing to-do list). The `pre-commit` hook blocks common key
  formats, but it is a backstop, not a guarantee.
- The `autoMode` block. Claude Code writes it into `settings.json` (through
  the symlink) and it describes your account, other repos, and environment.
  It stays in the live file as an uncommitted change; when committing
  settings, stage a copy without it: `jq 'del(.autoMode)'`.
- Permission rules that name private paths, hosts, or repos. Put them in a
  project's `.claude/settings.local.json`, which Claude Code keeps out of git.
- Everything else under `~/.claude/` (`history.jsonl`, `projects/` including
  memory, `sessions/`, `file-history/`, credentials, plugin cache): it holds
  conversation content and account state.
