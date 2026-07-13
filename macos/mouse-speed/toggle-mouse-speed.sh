#!/bin/bash
# Toggle the pointer tracking speed between a demo-stable setting and full speed.
#
#   FAST = 3.0  -> the macOS "Tracking speed" slider maximum (everyday use)
#   SLOW = 0.7  -> steadier pointer while presenting
#
# The change is applied live via the `mousespeed` IOKit helper (no re-login) and
# also written to `defaults` (both mouse and trackpad) so the chosen speed
# survives a logout/restart and stays in sync with System Settings. Bind this
# script to a shortcut (Karabiner shell_command, Raycast, macOS Shortcuts, etc.).
set -euo pipefail

# Karabiner (and other launchers) run shell_command with a bare environment, so
# pin the paths to awk / defaults / osascript / clang rather than trusting $PATH.
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-}"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN="$DIR/mousespeed"
SRC="$DIR/mousespeed.c"

FAST=3.0   # UI maximum
SLOW=0.7   # demo mode — steadier pointer

notify() {
    osascript -e "display notification \"$1\" with title \"Mouse speed\"" >/dev/null 2>&1 || true
}

# (Re)build the helper if it is missing or older than its source. This keeps the
# toggle working after a fresh clone or an edit to mousespeed.c, with no manual
# build step. Requires the Command Line Tools (clang).
if [ ! -x "$BIN" ] || [ "$SRC" -nt "$BIN" ]; then
    if ! clang -Wno-deprecated-declarations -framework IOKit -framework CoreFoundation \
        -o "$BIN" "$SRC" 2>/dev/null; then
        notify "Could not build the mousespeed helper (is clang installed?)"
        echo "mousespeed: build failed. Install Command Line Tools: xcode-select --install" >&2
        exit 1
    fi
fi

# Read the live speed; if that fails, assume fast so the first press goes to demo.
current="$("$BIN" get 2>/dev/null || echo "$FAST")"
midpoint="$(awk "BEGIN { print ($FAST + $SLOW) / 2 }")"

# Above the midpoint means we're currently fast -> drop to demo mode, else go fast.
if awk "BEGIN { exit !($current > $midpoint) }"; then
    target="$SLOW"
    label="demo ($SLOW)"
else
    target="$FAST"
    label="fast ($FAST)"
fi

# The live change is what matters for a demo; apply it first and bail loudly if
# it fails. Persisting to defaults (for login/reboot) is best-effort.
if ! "$BIN" set "$target"; then
    notify "Failed to set pointer speed"
    exit 1
fi
defaults write -g com.apple.mouse.scaling -float "$target" 2>/dev/null || true
defaults write -g com.apple.trackpad.scaling -float "$target" 2>/dev/null || true

notify "Tracking speed: $label"
