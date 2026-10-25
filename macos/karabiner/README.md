# Karabiner-Elements

The main keyboard remapping layer. `right_shift` is the primary modifier
layer (arrows via `hjkl`, symbols, app launchers); `option + letter` keys
are a reserved expansion area. See the repo root `CLAUDE.md`.

## Install

`install.sh` does this. Karabiner reads `~/.config/karabiner/karabiner.json`,
and its docs say to symlink the whole `~/.config/karabiner` directory, not the
file: Karabiner does not detect changes to a symlinked `karabiner.json`, and
its own saves replace the link with a regular file.

```sh
mv ~/.config/karabiner ~/.config/karabiner.backup   # if it already exists
ln -s ~/dotfiles/macos/karabiner ~/.config/karabiner
```

Then quit and reopen Karabiner-Elements so it watches the new location.
Verify the link and the reload:

```sh
ls -la ~/.config/karabiner
tail -5 ~/.local/share/karabiner/log/console_user_server.log
```

The log should end with `Load .../.config/karabiner/karabiner.json...`
followed by `core_configuration is updated.` Failing that, check
`/var/log/karabiner/grabber.log`.

## Editing

With the directory linked, the repo copy is the live config in both
directions: hand edits to `karabiner.json` reload immediately, and changes
made in the Karabiner GUI (rule edits, profile switches) are written into this
repo and show up in `git diff`.

Karabiner's writer collapses short arrays onto one line
(`"mandatory": ["left_option"]`) where the tracked file is fully expanded, so
a GUI save produces a large whitespace-only diff. To restore the tracked
formatting before committing:

```sh
python3 -c 'import json,sys; p=sys.argv[1]; d=json.load(open(p)); open(p,"w").write(json.dumps(d,indent=4,ensure_ascii=False))' karabiner.json
```

Karabiner also writes `automatic_backups/` and `assets/` into this directory;
both are git-ignored.

Shell commands in the rules use `$HOME/dotfiles/...`, so the clone has to
live at `~/dotfiles`.

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
