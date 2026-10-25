# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles across operating systems and devices. The guiding principle: **keep everything as default as possible — add custom configuration only when the pros clearly outweigh the cons.**

Color scheme principle: light theme tuned for long reading sessions — pure white background `#FFFFFF` `(255,255,255)` paired with pure black foreground `#000000` `(0,0,0)`, ~21:1 contrast, maximum legibility. iTerm2 also ships a mid-contrast variant (`#1A1A1A` foreground, ~17.4:1, see `macos/iterm/README.md`) for less glare over very long sessions. Display modes (warm, truetone, etc.) sit on top as wrappers.

## Commit convention

All commits must follow **Conventional Commits** format, enforced by
`git/hooks/commit-msg`. `install.sh` enables the repo's hooks with
`git config core.hooksPath git/hooks`; run that once by hand in a clone that
didn't go through `install.sh`. `git/hooks/pre-commit` also blocks commits
that look like they contain an API key, token, or private key.

```
type(scope)?: description
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`, `revert`. Use `!` after type for breaking changes.

Follow **atomic commits** and the Angular Conventional Commits guidelines as documented at https://github.com/qoomon/git-conventional-commits — each commit should be a single self-contained logical change (one concern per commit, do not bundle unrelated changes).

## Key configs

**install.sh** — sets up a Mac: Homebrew + `Brewfile`, symlinks configs into place, runs `macos/macos-settings.bash` and `macos/security-check.sh`. Idempotent; `--dry-run` previews. Must stay compatible with macOS's stock bash 3.2. When adding a config, add its `link` line there.

**Karabiner** (`macos/karabiner/karabiner.json`) — the main keyboard remapping layer. The `right_shift` key is the primary modifier layer (arrows via `hjkl`, symbols, app launchers, etc.). `option + letter` keys are a reserved expansion area. `~/.config/karabiner` is a symlink to `macos/karabiner/`, so GUI edits land in the repo.

**zsh/zshrc** — sourced from a machine-local `~/.zshrc`, which keeps secrets. Loads oh-my-zsh, `bash_aliases`, powerlevel10k (`zsh/p10k.zsh`) and nvm.

**bash_aliases** — sourced from `zsh/zshrc` (or `~/.bashrc` on WSL). Contains `j()` navigation functions, fzf alias (`s`), vifm alias (`d`), nvim alias (`k`), and a full oh-my-zsh-compatible git alias set (only loaded when oh-my-zsh's git plugin isn't).

**git/** — `config` (included from `~/.gitconfig`), the global `ignore`, and this repo's hooks.

**macos/macos-settings.bash** — system `defaults` settings; run by `install.sh`, or by hand.

**vifmrc** — vifm file manager config. On first setup, run `:view` inside vifm to enable tree preview.
