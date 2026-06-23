# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal system configuration ("sf" = system files) for macOS, Windows, Linux, iOS, and cross-platform tools. The guiding principle: **keep everything as default as possible — add custom configuration only when the pros clearly outweigh the cons.**

Color scheme principle: light theme tuned for long reading sessions — slightly off-white background `#EEEEEE` `(238,238,238)` paired with slightly off-black foreground `#303030` `(48,48,48)`. Avoid pure `#FFFFFF` / `#000000` because maximum-luminance backgrounds and maximum-contrast text cause eye fatigue over hours of use. Display modes (warm, truetone, etc.) sit on top as wrappers.

## Structure

- Root — OS-agnostic files (`bash_aliases`, `vifmrc`, `nvim/`, `vs-code/`)
- `macos/` — Karabiner config (`karabiner/karabiner.json`), macOS system settings script, iTerm2 color presets (`iterm/`)
- `windows/` — AutoHotKey remapping script
- `linux/` — WSL2 Ubuntu package list
- `ios/` — iOS Shortcuts scripts and automation notes

## Commit convention

All commits must follow **Conventional Commits** format (enforced via `commit-enforcer.sh`):

```
type(scope)?: description
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`, `revert`. Use `!` after type for breaking changes.

Follow **atomic commits** and the Angular Conventional Commits guidelines as documented at https://github.com/qoomon/git-conventional-commits — each commit should be a single self-contained logical change (one concern per commit, do not bundle unrelated changes).

## Key configs

**Karabiner** (`macos/karabiner/karabiner.json`) — the main keyboard remapping layer. Key mappings are documented in `README.md`. The `right_shift` key is the primary modifier layer (arrows via `hjkl`, symbols, app launchers, etc.). `option + letter` keys are a reserved expansion area.

**bash_aliases** — sourced from `~/.zshrc`/`~/.bashrc`. Contains `j()` navigation functions, fzf alias (`s`), vifm alias (`d`), nvim alias (`k`), and a full oh-my-zsh-compatible git alias set (only loaded when oh-my-zsh is not present).

**macos/macos-settings.bash** — run manually after a fresh macOS install to apply system `defaults` settings.

**vifmrc** — vifm file manager config. On first setup, run `:view` inside vifm to enable tree preview.
