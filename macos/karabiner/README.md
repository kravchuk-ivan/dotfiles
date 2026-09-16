# Karabiner-Elements

The main keyboard remapping layer. `right_shift` is the primary modifier
layer (arrows via `hjkl`, symbols, app launchers); `option + letter` keys
are a reserved expansion area. See the repo root `CLAUDE.md`.

## Install

Karabiner reads a single config file at
`~/.config/karabiner/karabiner.json`. If one already exists as a real
file, keep a copy before replacing it:

```sh
cp ~/.config/karabiner/karabiner.json \
   ~/.config/karabiner/karabiner.json.pre-symlink.bak
```

Then symlink this repo's copy into place:

```sh
ln -sfn "$PWD/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
```

`-n` keeps `ln` from following an existing link and nesting a new one
inside it, so re-running the command replaces the link in place.

No restart is needed — Karabiner watches the file and reloads within
milliseconds. Verify both the link and the reload:

```sh
ls -la ~/.config/karabiner/karabiner.json
tail -5 ~/.local/share/karabiner/log/console_user_server.log
```

The log should end with `Load /Users/<you>/.config/karabiner/karabiner.json...`
followed by `core_configuration is updated.` Failing that, check
`/var/log/karabiner/grabber.log`.

## The symlink is absolute

Moving or renaming the clone leaves a dangling link, and Karabiner fails
quietly: it keeps running on the last-loaded config, so nothing appears
broken until a restart drops every remapping at once. After relocating
the repo, re-run the `ln` command above and confirm:

```sh
test -e ~/.config/karabiner/karabiner.json && echo OK || echo BROKEN
```

## Editing

Changes made in the Karabiner GUI are written back to
`karabiner.json`, so they land in this repo as a normal diff:

```sh
git -C ~/dotfiles status --short
```

If a Karabiner update ever replaces the symlink with a regular file
instead of writing through it, that diff will be missing. Copy the live
file back over `macos/karabiner/karabiner.json`, then re-run the `ln`
command to restore the link.

Hand-editing the JSON while Karabiner is running is fine — it reloads on
save and ignores a malformed file rather than wiping the config, but it
will keep using the last valid version until the syntax error is fixed.

## Profiles

| Profile | Contents |
| --- | --- |
| **Pro** | Active profile. 50 complex-modification rules, 5 device-specific entries. |
| **Guest** | Deliberately empty — stock keyboard behavior for lending the machine. |

Switch between them from the menu bar icon or Karabiner → Profiles.

## All modifications live in karabiner.json

Karabiner also reads rule files dropped into
`~/.config/karabiner/assets/complex_modifications/`, but that directory is
only an import *source* for the GUI — the config it actually loads is
`karabiner.json` alone. This repo deliberately leaves it unused.

A rule parked there looks tracked while being inactive, which is how the
"open iTerm2 in the current Finder folder" rule sat dormant for four months
before being inlined. Add new rules to `karabiner.json` itself,
through the GUI or by hand, and there stays exactly one source of truth.
