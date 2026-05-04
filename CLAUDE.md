# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal system configuration ("sf" = system files) for macOS, Windows, Linux, iOS, and cross-platform tools. The guiding principle: **keep everything as default as possible — add custom configuration only when the pros clearly outweigh the cons.**

Color scheme principle: background white `(255,255,255)`, foreground black `(0,0,0)` for maximum readability. Display modes (warm, truetone, etc.) are wrappers on top.

## Structure

- Root — OS-agnostic files (`bash_aliases`, `vifmrc`, `nvim/`, `vs-code/`)
- `macos/` — Karabiner config (`karabiner/karabiner.json`), macOS system settings script
- `windows/` — AutoHotKey remapping script
- `linux/` — WSL2 Ubuntu package list
- `ios/` — iOS Shortcuts scripts and automation notes

## Commit convention

All commits must follow **Conventional Commits** format (enforced via `commit-enforcer.sh`):

```
type(scope)?: description
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`, `revert`. Use `!` after type for breaking changes.

## Key configs

**Karabiner** (`macos/karabiner/karabiner.json`) — the main keyboard remapping layer. Key mappings are documented in `README.md`. The `right_shift` key is the primary modifier layer (arrows via `hjkl`, symbols, app launchers, etc.). `option + letter` keys are a reserved expansion area.

**bash_aliases** — sourced from `~/.zshrc`/`~/.bashrc`. Contains `j()` navigation functions, fzf alias (`s`), vifm alias (`d`), nvim alias (`k`), and a full oh-my-zsh-compatible git alias set (only loaded when oh-my-zsh is not present).

**macos/macos-settings.bash** — run manually after a fresh macOS install to apply system `defaults` settings.

**vifmrc** — vifm file manager config. On first setup, run `:view` inside vifm to enable tree preview.
