# iTerm2 color presets

Portable color presets for the "dotfiles" reading-optimized scheme. See the
color-scheme rationale in the repo root `CLAUDE.md` / `README.md`.

- `dotfiles-charcoal-light.itermcolors` — light theme, mid contrast. Background
  `#FFFFFF` (255,255,255), foreground `#1A1A1A` (26,26,26). ~17.4:1
  contrast, above WCAG AAA (7:1).
- `dotfiles-black-light.itermcolors` — light theme, max contrast. Background
  `#FFFFFF` (255,255,255), foreground `#000000` (0,0,0). ~21:1 contrast,
  maximum — sharpest text.
- `dotfiles-off-black-dark.itermcolors` — dark counterpart, for low-light use.
  Background `#1E1E1E` (30,30,30), foreground `#D0D0D0` (208,208,208),
  ~11:1 contrast to match the light theme. Deliberately avoids pure black:
  an off-black floor removes the halation (text glow/bleed) that `#000000`
  causes against bright glyphs. ANSI "black" is lifted to `#3A3A3A` so
  ANSI-black output stays legible against the background.

## Apply on a new machine

1. iTerm2 → Settings → Profiles → Colors.
2. Color Presets… (bottom-right) → Import… → select the `.itermcolors`
   file(s) from this folder.
3. Color Presets… → choose whichever light variant you want
   (`dotfiles-charcoal-light` or `dotfiles-black-light`) and `dotfiles-off-black-dark`. To
   auto-switch with macOS appearance, enable "Use different colors for
   light/dark mode" and pick a preset for each.

## Re-export after tweaking colors in the GUI

iTerm2 → Settings → Profiles → Colors → Color Presets… → Export… and
overwrite the file here, then commit.
