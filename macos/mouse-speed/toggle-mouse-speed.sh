#!/bin/bash
# Toggle the pointer tracking speed between a demo-stable setting and full speed.
#
#   FAST = 3.0  -> the macOS "Tracking speed" slider maximum (everyday use)
#   SLOW = 1.0  -> a third of that (steadier pointer while presenting)
#
# The change is applied live via the `mousespeed` IOKit helper (no re-login) and
# also written to `defaults` (both mouse and trackpad) so the chosen speed
# survives a logout/restart and stays in sync with System Settings. Bind this
# script to a shortcut (Karabiner shell_command, Raycast, macOS Shortcuts, etc.).
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN="$DIR/mousespeed"

FAST=3.0   # UI maximum
SLOW=1.0   # demo mode — steadier pointer

if [ ! -x "$BIN" ]; then
    echo "mousespeed helper not built. Build it with:" >&2
    echo "  clang -Wno-deprecated-declarations -framework IOKit -framework CoreFoundation -o '$BIN' '$DIR/mousespeed.c'" >&2
    exit 1
fi

current="$("$BIN" get)"
midpoint="$(awk "BEGIN { print ($FAST + $SLOW) / 2 }")"

# Above the midpoint means we're currently fast -> drop to demo mode, else go fast.
if awk "BEGIN { exit !($current > $midpoint) }"; then
    target="$SLOW"
    label="demo ($SLOW)"
else
    target="$FAST"
    label="fast ($FAST)"
fi

"$BIN" set "$target"
defaults write -g com.apple.mouse.scaling -float "$target"
defaults write -g com.apple.trackpad.scaling -float "$target"

osascript -e "display notification \"Tracking speed: $label\" with title \"Mouse speed\"" \
    >/dev/null 2>&1 || true
