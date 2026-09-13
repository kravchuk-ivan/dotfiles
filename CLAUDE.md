# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles across operating systems and devices. The guiding principle: **keep everything as default as possible — add custom configuration only when the pros clearly outweigh the cons.**

Color scheme principle: light theme tuned for long reading sessions — pure white background `#FFFFFF` `(255,255,255)` paired with pure black foreground `#000000` `(0,0,0)`, ~21:1 contrast, maximum legibility. iTerm2 also ships a mid-contrast variant (`#1A1A1A` foreground, ~17.4:1, see `macos/iterm/README.md`) for less glare over very long sessions. Display modes (warm, truetone, etc.) sit on top as wrappers.

## Commit convention

All commits must follow **Conventional Commits** format. `commit-enforcer.sh`
holds a `commit-msg` hook template for this (copy its `commit-msg` and
`text-styles.sh` sections into `.git/hooks/` to activate it — not installed
by default, so nothing currently enforces this automatically):

```
type(scope)?: description
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`, `revert`. Use `!` after type for breaking changes.

Follow **atomic commits** and the Angular Conventional Commits guidelines as documented at https://github.com/qoomon/git-conventional-commits — each commit should be a single self-contained logical change (one concern per commit, do not bundle unrelated changes).

## Key configs

**Karabiner** (`macos/karabiner/karabiner.json`) — the main keyboard remapping layer. The `right_shift` key is the primary modifier layer (arrows via `hjkl`, symbols, app launchers, etc.). `option + letter` keys are a reserved expansion area.

**bash_aliases** — sourced from `~/.zshrc`/`~/.bashrc`. Contains `j()` navigation functions, fzf alias (`s`), vifm alias (`d`), nvim alias (`k`), and a full oh-my-zsh-compatible git alias set (only loaded when oh-my-zsh is not present).

**macos/macos-settings.bash** — run manually after a fresh macOS install to apply system `defaults` settings.

**vifmrc** — vifm file manager config. On first setup, run `:view` inside vifm to enable tree preview.
