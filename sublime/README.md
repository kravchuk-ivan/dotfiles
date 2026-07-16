# Sublime Text

Light, near-default Sublime Text 4 setup. Color scheme is the built-in
**Celeste** (Sublime's own light theme — no package required), keeping with the
repo principle of staying as default as possible.

## Install

Settings files live in the Sublime user directory:

- macOS: `~/Library/Application Support/Sublime Text/Packages/User/`
- Linux: `~/.config/sublime-text/Packages/User/`
- Windows: `%APPDATA%\Sublime Text\Packages\User\`

Symlink (recommended, keeps them tracked) or copy:

```sh
SUBLIME="$HOME/Library/Application Support/Sublime Text/Packages/User"
ln -sf "$PWD/Preferences.sublime-settings" "$SUBLIME/Preferences.sublime-settings"
ln -sf "$PWD/Package Control.sublime-settings" "$SUBLIME/Package Control.sublime-settings"
```

Then restart Sublime. To just switch the theme without the settings file:
command palette (`⌘⇧P`) → **UI: Select Color Scheme** → **Celeste**.

## Recommended packages

Install [Package Control](https://packagecontrol.io/installation) first, then
the `Package Control.sublime-settings` list auto-installs these:

| Package | Why |
| --- | --- |
| **LSP** | Real autocomplete, go-to-definition, and diagnostics via language servers. The single biggest upgrade to stock Sublime. |
| **GitGutter** | Inline git diff markers in the gutter. |
| **SublimeLinter** | Linting framework (add `SublimeLinter-eslint`, `-flake8`, etc. per language). |
| **MarkdownEditing** | Much better Markdown syntax + editing. |
| **A File Icon** | File-type icons in sidebar/tabs. |
| **NeoVintageous** | Modern Vim emulation — consistent with your nvim / vifm / VS Code Vim setup. |

Worth knowing but left out of the auto-install list: **Terminus** (integrated
terminal), **BracketHighlighter**, **SideBarEnhancements**, **Origami** (pane
splitting).
