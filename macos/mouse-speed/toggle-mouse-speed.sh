#!/bin/bash
# Toggle pointer tracking speed AND scroll speed between a demo-stable setting
# and full speed.
#
#   FAST = 3.0  -> the macOS "Tracking speed" slider maximum (everyday use)
#   SLOW = 0.7  -> steadier pointer while presenting
#
# Pointer speed is applied live via the `mousespeed` IOKit helper (no re-login)
# and written to `defaults` so it survives a logout/restart.
#
# Scroll speed is handled separately by the `scrollslow` event tap: the macOS
# HID scroll curve only slows some devices (the trackpad honours it, hi-res
# mice ignore it), so we scale the scroll events themselves instead — one
# mechanism that slows the trackpad and the mouse alike. Demo mode launches the
# tap; fast mode kills it, so nothing runs during normal use. The tap needs a
# one-time Accessibility grant (System Settings > Privacy & Security).
#
# Bind this script to a shortcut (Karabiner shell_command, Raycast, etc.).
set -euo pipefail

# Karabiner (and other launchers) run shell_command with a bare environment, so
# pin the paths to awk / defaults / osascript / clang rather than trusting $PATH.
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-}"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN="$DIR/mousespeed"
SRC="$DIR/mousespeed.c"
SCROLL_BIN="$DIR/scrollslow"
SCROLL_SRC="$DIR/scrollslow.c"

FAST=3.0   # UI maximum
SLOW=0.7   # demo mode — steadier pointer

# Scroll delta multiplier used in demo mode (1 = untouched, 0 = frozen). 0.3
# gives a distinctly slower, steadier scroll for presenting.
SCROLL_FACTOR=0.3

notify() {
    osascript -e "display notification \"$1\" with title \"Mouse speed\"" >/dev/null 2>&1 || true
}

# (Re)build a helper if it is missing or older than its source, so the toggle
# works after a fresh clone or a source edit with no manual build step.
build() {  # build <out> <src> <frameworks...>
    local out="$1" src="$2"; shift 2
    [ -x "$out" ] && [ ! "$src" -nt "$out" ] && return 0
    if ! clang -Wno-deprecated-declarations "$@" -o "$out" "$src" 2>/dev/null; then
        notify "Could not build $(basename "$out") (is clang installed?)"
        echo "build failed for $out. Install Command Line Tools: xcode-select --install" >&2
        return 1
    fi
}
build "$BIN" "$SRC" -framework IOKit -framework CoreFoundation || exit 1
build "$SCROLL_BIN" "$SCROLL_SRC" -framework ApplicationServices -framework CoreFoundation || exit 1

# Read the live speed; if that fails, assume fast so the first press goes to demo.
current="$("$BIN" get 2>/dev/null || echo "$FAST")"
midpoint="$(awk "BEGIN { print ($FAST + $SLOW) / 2 }")"

# Above the midpoint means we're currently fast -> drop to demo mode, else go fast.
if awk "BEGIN { exit !($current > $midpoint) }"; then
    target="$SLOW"; mode="demo"
else
    target="$FAST"; mode="fast"
fi

# Pointer: apply live (what matters for a demo) and bail loudly if it fails;
# persisting to defaults for login/reboot is best-effort.
if ! "$BIN" set "$target"; then
    notify "Failed to set pointer speed"
    exit 1
fi
defaults write -g com.apple.mouse.scaling -float "$target" 2>/dev/null || true
defaults write -g com.apple.trackpad.scaling -float "$target" 2>/dev/null || true

# Scroll: start the tap for demo, kill it for fast. Always kill any existing
# instance first so a repeated demo press re-applies the current factor.
pkill -f "$SCROLL_BIN" 2>/dev/null || true
if [ "$mode" = "demo" ]; then
    nohup "$SCROLL_BIN" "$SCROLL_FACTOR" >/dev/null 2>&1 &
    disown 2>/dev/null || true
    # If it died immediately, the Accessibility grant is almost certainly missing.
    sleep 0.4
    if ! pgrep -f "$SCROLL_BIN" >/dev/null 2>&1; then
        notify "Enable scrollslow in Accessibility, then press option+m again"
    fi
fi

notify "Tracking + scroll: $mode ($target)"
