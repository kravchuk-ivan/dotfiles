# iTerm2 color presets

Portable color presets for the "sf" reading-optimized scheme. See the
color-scheme rationale in the repo root `CLAUDE.md` / `README.md`.

- `sf-off-white-light.itermcolors` — light theme. Background `#EEEEEE`
  (238,238,238), foreground `#303030` (48,48,48). ~11:1 contrast: above
  WCAG AAA (7:1) for legibility, but short of pure black-on-white (21:1)
  to avoid the glare/halation that fatigues the eyes over long sessions.
- `sf-off-black-dark.itermcolors` — dark counterpart, for low-light use.
  Background `#1E1E1E` (30,30,30), foreground `#D0D0D0` (208,208,208),
  ~11:1 contrast to match the light theme. Deliberately avoids pure black:
  an off-black floor removes the halation (text glow/bleed) that `#000000`
  causes against bright glyphs. ANSI "black" is lifted to `#3A3A3A` so
  ANSI-black output stays legible against the background.

## Apply on a new machine

1. iTerm2 → Settings → Profiles → Colors.
2. Color Presets… (bottom-right) → Import… → select the `.itermcolors`
   file(s) from this folder.
3. Color Presets… → choose `sf-off-white-light` (and `sf-off-black-dark`).
   To auto-switch with macOS appearance, enable "Use different colors for
   light/dark mode" and pick a preset for each.

## Re-export after tweaking colors in the GUI

iTerm2 → Settings → Profiles → Colors → Color Presets… → Export… and
overwrite the file here, then commit.
