#!/usr/bin/env bash
# Install the dotfiles iTerm2 profile and make it the default profile. Only
# touches this profile and three iTerm2 preferences; other profiles and
# settings are left alone. Safe to re-run. install.sh calls it.
#
#   ~/dotfiles/macos/iterm/setup.sh             apply
#   ~/dotfiles/macos/iterm/setup.sh --dry-run   show what would change
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE="$HERE/dotfiles-profile.json"
ITERM_SUPPORT="$HOME/Library/Application Support/iTerm2"
DEST="$ITERM_SUPPORT/DynamicProfiles/dotfiles-profile.json"
DOMAIN=com.googlecode.iterm2

DRY_RUN=0
case "${1:-}" in
    "") ;;
    -n | --dry-run) DRY_RUN=1 ;;
    *) echo "usage: $0 [--dry-run]" >&2; exit 64 ;;
esac

note() { printf '    %s\n' "$*"; }
run() {
    if [ "$DRY_RUN" = 1 ]; then note "would run: $*"; else "$@"; fi
}
did() { [ "$DRY_RUN" = 1 ] || note "$@"; }

guid=$(sed -n 's/.*"Guid": "\(.*\)".*/\1/p' "$PROFILE")

# 1. Link the profile. iTerm2 watches this folder and picks the profile up
# within seconds, whether or not it's running.
if [ "$(readlink "$DEST" 2>/dev/null || true)" = "$PROFILE" ]; then
    note "iTerm2: profile already linked"
else
    if [ -e "$DEST" ] || [ -L "$DEST" ]; then
        # iTerm2 loads every file in DynamicProfiles, so a backup left there
        # would be a second profile with the same Guid. Keep it outside.
        backup="$ITERM_SUPPORT/dotfiles-profile.json.backup-$(date +%Y%m%d-%H%M%S)"
        run mv "$DEST" "$backup"
        did "iTerm2: moved existing $DEST to $backup"
    fi
    run mkdir -p "$(dirname "$DEST")"
    run ln -s "$PROFILE" "$DEST"
    did "iTerm2: linked $DEST"
fi

# iTerm2 ignores a dynamic profile whose Guid matches a regular profile's,
# which happens if the JSON was once imported by hand in Settings.
if defaults read "$DOMAIN" "New Bookmarks" 2>/dev/null | grep -qF "$guid"; then
    note "iTerm2: a regular profile has the dotfiles Guid, so the dotfiles profile is ignored."
    note "  Delete that copy in Settings > Profiles, then run this script again."
fi

# 2. Preferences. iTerm2 rewrites its preferences on quit, so only write them
# while it's closed. -a: pgrep skips its own ancestors, and this script often
# runs inside iTerm2.
if pgrep -axq iTerm2; then
    note "iTerm2 is running, so its preferences were not changed. Either:"
    note "  - Settings > Profiles > dotfiles > Other Actions... > Set as Default, or"
    note "  - quit iTerm2 and run $HERE/setup.sh from Terminal.app"
    exit 0
fi
if [ "$(defaults read "$DOMAIN" "Default Bookmark Guid" 2>/dev/null || true)" = "$guid" ]; then
    note "iTerm2: dotfiles profile is already the default"
else
    run defaults write "$DOMAIN" "Default Bookmark Guid" -string "$guid"
    did "iTerm2: dotfiles profile is the default"
fi
# Security fixes ship as iTerm2 point releases.
run defaults write "$DOMAIN" SUEnableAutomaticChecks -bool true
# Otherwise the last copied/pasted values, secrets included, are saved to disk.
run defaults write "$DOMAIN" SavePasteHistory -bool false
did "iTerm2: update checks on; paste history off"
