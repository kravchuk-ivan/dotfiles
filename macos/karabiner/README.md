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

No restart is needed: replacing the symlink is itself a change to the path
Karabiner watches, so it reloads immediately. Verify the link and the reload:

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

Karabiner watches the *path* `~/.config/karabiner/karabiner.json`, not the
file the symlink resolves to. Two consequences, both verified on 15.5.0:

**Hand-editing this repo's `karabiner.json` reloads nothing.** Karabiner
keeps running whatever it loaded last, so the change looks applied but
isn't. Re-run the `ln -sfn` command from Install to pick it up — replacing
the symlink registers as a change to the watched path. A `touch` through
the link does not work.

**Karabiner's own writes replace the symlink with a regular file.** A GUI
edit, a profile switch, or `karabiner_cli --select-profile` all write a
fresh file to that path, so the link is gone and the change stays in
`~/.config/`, never reaching this repo. To recover, copy the live file back
and relink:

```sh
cp ~/.config/karabiner/karabiner.json ~/dotfiles/macos/karabiner/karabiner.json
ln -sfn ~/dotfiles/macos/karabiner/karabiner.json \
        ~/.config/karabiner/karabiner.json
```

Expect a large whitespace diff if you do: Karabiner's writer collapses short
arrays onto one line (`"mandatory": ["left_option"]`) where the tracked file
is fully expanded — 1062 lines against 1483 for byte-different but
semantically identical data. Hand-editing the repo file keeps diffs
readable, so prefer it for anything you can express directly.

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
