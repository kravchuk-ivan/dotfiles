# Claude Code

| Repo file       | Installed as               | How                     | Contents                               |
| --------------- | -------------------------- | ----------------------- | -------------------------------------- |
| `settings.json` | `~/.claude/settings.json`  | merged into a local copy | User settings for every project        |
| `CLAUDE.md`     | `~/.claude/CLAUDE.md`      | symlink                 | Instructions loaded into every session |

Claude Code installs separately: `curl -fsSL https://claude.ai/install.sh | bash`.

## Why settings.json is merged, not linked

Claude Code writes its own state into `~/.claude/settings.json`. Auto mode,
for example, stores a description of your account, your other repos, and
your environment there. A symlink would put all of that into this public
repo. So `~/.claude/settings.json` is a regular, machine-local file, and
`install.sh` merges `claude/settings.json` into it with `jq`:

- keys in the repo file are set, overriding the local value;
- keys only in the local file (`autoMode` and anything else Claude Code
  adds) are kept;
- the previous file is saved as `settings.json.backup-<timestamp>` when
  anything changes;
- an old symlink from an earlier `install.sh` is turned into a local copy.

A change made with `/config` stays on this machine. To share it, copy that
key into `claude/settings.json` by hand and commit it.

## Settings

- `statusLine`: prints the session's working directory (full path, in bold)
  below the prompt. It reads the JSON Claude Code passes on stdin with `jq`,
  which ships with macOS 15 and later at `/usr/bin/jq`.
- `theme: light`: matches the light color scheme used across the repo.
- `permissions.defaultMode: auto`, `tui: fullscreen`, and the rest are
  preferences set through `/config`.

## What stays out of the repo

This repo is public. Keep these machine-local:

- API keys and tokens. Do not use the `env` block in `settings.json` for
  them. Export them from `~/.zshrc` or read them from the Keychain (see
  `install.sh`'s closing to-do list). The `pre-commit` hook blocks common key
  formats, but it is a backstop, not a guarantee.
- Permission rules that name private paths, hosts, or repos. Put them in a
  project's `.claude/settings.local.json`, which Claude Code keeps out of git.
- Everything else under `~/.claude/` (`history.jsonl`, `projects/` including
  memory, `sessions/`, `file-history/`, credentials, plugin cache): it holds
  conversation content and account state.

`CLAUDE.md` is linked, so edits made with `/memory` land in the repo. Review
them in `git diff` before committing.
