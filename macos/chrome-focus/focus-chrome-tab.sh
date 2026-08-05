#!/bin/bash
# Focus an already-open Google Chrome tab, or open the URL in a new tab.
#
#   focus-chrome-tab.sh <url-prefix> <url-to-open>
#
# The first argument is the prefix a tab's URL must start with to count as "the
# same page" (use an account-scoped prefix such as
# "https://mail.google.com/mail/u/0/" so the u/1 inbox is not mistaken for u/0).
# The second is the URL to open when no such tab exists.
#
# Search covers every tab of every normal window, including windows that are
# minimized (the window is un-minimized) or on another Space (Chrome switches to
# it). Incognito windows are skipped on purpose — a private window should not be
# yanked onto a shared screen mid-demo.
#
# Design notes, since this runs off a keypress:
#
#   * The AppleScript only ever *reads* tab URLs and *focuses* a window. It
#     cannot create, close, or navigate a tab, and it never uses `execute
#     javascript`. Opening is always delegated to `open -a`, i.e. plain
#     LaunchServices.
#   * Both arguments are passed to osascript as `on run argv` parameters, never
#     interpolated into the script text, so a URL can't alter what runs.
#   * Sending Apple events to Chrome needs a one-time Automation grant for
#     whatever invokes this (for Karabiner that is
#     `karabiner_console_user_server`). If the grant is missing, the earlier
#     version of this binding silently did nothing; here the failure is
#     reported and the URL still opens.
#   * Every failure path ends in "open the URL anyway", and the Apple event is
#     capped at 5 seconds, so a wedged Chrome can't leave the keypress hanging.
set -euo pipefail

# Karabiner runs shell_command with a bare environment, so pin the paths to
# pgrep / osascript / open rather than trusting $PATH.
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"

CHROME_APP="Google Chrome"

PREFIX="${1:-}"
URL="${2:-}"
if [[ -z "$PREFIX" || -z "$URL" ]]; then
    echo "usage: $(basename "$0") <url-prefix> <url-to-open>" >&2
    exit 64
fi

notify() {
    # Pass the message as an argument, not as script text, for the same reason
    # the URL is passed as argv below.
    osascript -e 'on run {msg}' \
        -e 'display notification msg with title "Chrome tab"' \
        -e 'end run' "$1" >/dev/null 2>&1 || true
}

open_new_tab() {
    open -a "$CHROME_APP" "$URL"
}

# Chrome not running: nothing to search, and `tell application` would launch it
# behind our back. -x matches the exact process name, so Chrome Canary does not
# count as Chrome.
if ! pgrep -x "$CHROME_APP" >/dev/null 2>&1; then
    open_new_tab
    exit 0
fi

set +e
result="$(osascript - "$PREFIX" 2>&1 <<'APPLESCRIPT'
on run argv
	set matchPrefix to item 1 of argv

	with timeout of 5 seconds
		tell application "Google Chrome"
			set foundId to missing value
			set foundIndex to 0

			repeat with w in windows
				if mode of w is "normal" then
					set tabIndex to 0
					repeat with t in tabs of w
						set tabIndex to tabIndex + 1
						set tabURL to ""
						try
							set tabURL to (URL of t) as text
						end try
						if tabURL starts with matchPrefix then
							set foundId to id of w
							set foundIndex to tabIndex
							exit repeat
						end if
					end repeat
				end if
				if foundIndex > 0 then exit repeat
			end repeat

			if foundId is missing value then return "notfound"

			-- Address the window by id rather than by position, so nothing
			-- here depends on window order: bringing a window to the front
			-- renumbers the rest.
			tell window id foundId
				try
					if minimized then set minimized to false
				end try
				set active tab index to foundIndex
				try
					set index to 1
				end try
			end tell
			activate
		end tell
	end timeout

	return "found"
end run
APPLESCRIPT
)"
status=$?
set -e

if [[ $status -eq 0 && "$result" == "found" ]]; then
    exit 0
fi

if [[ $status -ne 0 ]]; then
    case "$result" in
        *-1743* | *"not allowed"* | *"not authorized"*)
            notify "Allow Automation for Karabiner in System Settings > Privacy & Security > Automation, then press the key again." ;;
        *"timed out"* | *-1712*)
            notify "Chrome did not answer in time; opened a new tab instead." ;;
        *)
            notify "Could not check Chrome tabs; opened a new tab instead." ;;
    esac
fi

open_new_tab
