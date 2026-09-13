# iTerm2 color presets

Portable color presets for the "dotfiles" reading-optimized scheme. See the
color-scheme rationale in the repo root `CLAUDE.md` / `README.md`.

- `dotfiles-light-mid-contrast.itermcolors` — light theme, mid contrast.
  Background `#FFFFFF` (255,255,255), foreground `#1A1A1A` (26,26,26).
  ~17.4:1 contrast, above WCAG AAA (7:1). Less glare on very long sessions.
- `dotfiles-light-max-contrast.itermcolors` — light theme, max contrast.
  Background `#FFFFFF` (255,255,255), foreground `#000000` (0,0,0). ~21:1
  contrast, maximum — sharpest text.
- `dotfiles-dark-mid-contrast.itermcolors` — dark theme, mid contrast.
  Background `#1E1E1E` (30,30,30), foreground `#D0D0D0` (208,208,208),
  ~11:1 contrast. Deliberately avoids pure black: an off-black floor
  removes the halation (text glow/bleed) that `#000000` causes against
  bright glyphs.
- `dotfiles-dark-max-contrast.itermcolors` — dark theme, max contrast.
  Background `#000000` (0,0,0), foreground `#FFFFFF` (255,255,255), ~21:1
  contrast, maximum — mirrors the light max-contrast preset.

Both dark variants lift ANSI "black" to `#3A3A3A` so black-colored text
stays legible against the dark background instead of disappearing into it
— a background-color problem that light themes don't have, since black
text renders fine against a white background.

## Apply on a new machine

1. iTerm2 → Settings → Profiles → Colors.
2. Color Presets… (bottom-right) → Import… → select the `.itermcolors`
   file(s) from this folder.
3. Color Presets… → choose whichever light variant you want
   (`dotfiles-light-mid-contrast` or `dotfiles-light-max-contrast`) and
   whichever dark variant you want (`dotfiles-dark-mid-contrast` or
   `dotfiles-dark-max-contrast`). To auto-switch with macOS appearance,
   enable "Use different colors for light/dark mode" and pick a preset for
   each.

## Re-export after tweaking colors in the GUI

iTerm2 → Settings → Profiles → Colors → Color Presets… → Export… and
overwrite the file here, then commit.
