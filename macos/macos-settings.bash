#!/usr/bin/env bash
set -euo pipefail

# --- Login Window ---

# Disable the lock button on Magic Keyboard (the model without Touch ID).
# On that keyboard the lock key is easy to hit accidentally — a stray keystroke
# logs you out mid-work. DisableScreenLockImmediate removes it from the lock screen
# UI without affecting any other security setting.
defaults write com.apple.loginwindow DisableScreenLockImmediate -bool true
echo "APPLIED SETTING: Login window: accidental-lock button disabled."

# --- Input ---

# Disable the press-and-hold popup (accented character picker) and enable key repeat
# instead. Without this, holding a key shows a picker rather than repeating the character —
# which makes arrow-key navigation and backspace sluggish in every app.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
echo "APPLIED SETTING: Key repeat: enabled (press-and-hold accent picker disabled)."

# How fast a held key fires after the initial delay. The System Settings slider exposes
# values from 2 (Fast) to 120 (Slow); default is ~6. Setting 2 = fastest in the UI range.
defaults write NSGlobalDomain KeyRepeat -int 2
echo "APPLIED SETTING: Key repeat: rate set to 2 (maximum within System Settings range)."

# How long you must hold a key before it starts repeating. The System Settings slider
# exposes values from 15 (Short) to 120 (Long); default is ~25. Setting 15 = shortest in range.
defaults write NSGlobalDomain InitialKeyRepeat -int 15
echo "APPLIED SETTING: Key repeat: initial delay set to 15 (minimum within System Settings range)."

# Full keyboard access: Tab cycles through ALL interactive UI controls — buttons,
# checkboxes, radio buttons, sliders — not just text fields and lists (the default).
# Without this, confirmation dialogs require a mouse click even when Tab is available.
# With it, Tab focuses the button and Space activates it, enabling keyboard-only flows.
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
echo "APPLIED SETTING: Keyboard: full UI access enabled (Tab navigates all controls)."

# Tap to click: register a light tap (no physical click force) as a left click.
# Reduces finger fatigue vs. pressing the physical trackpad for every action.
# Must be written to three domains: the built-in trackpad driver, the Bluetooth
# trackpad driver, and the global mouse behavior key that apps read to honor it.
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
echo "APPLIED SETTING: Trackpad: tap-to-click enabled (built-in driver)."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
echo "APPLIED SETTING: Trackpad: tap-to-click enabled (Bluetooth driver)."
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
echo "APPLIED SETTING: Trackpad: tap-to-click enabled (global mouse behavior)."

# Three-finger drag: drag windows and select text by sliding three fingers across
# the trackpad surface — no click-and-hold required. More ergonomic for long movements.
# Potential overlap with three-finger swipe gestures (Mission Control, app exposé) is
# resolved by macOS context: a drag only begins when fingers land on a draggable surface.
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
echo "APPLIED SETTING: Trackpad: three-finger drag enabled (built-in driver)."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
echo "APPLIED SETTING: Trackpad: three-finger drag enabled (Bluetooth driver)."

# --- Dock ---

# Hide all pinned/persistent app icons; show only currently running apps.
# Keeps the Dock minimal — you launch apps via Spotlight, not the Dock.
defaults write com.apple.dock static-only -bool true
echo "APPLIED SETTING: Dock: active-apps-only mode enabled (pinned icons hidden)."

# Hide the "Recent Applications" cluster that appears after the Dock divider.
# Without this, macOS still shows the last 3 opened apps even with static-only=true.
defaults write com.apple.dock show-recents -bool false
echo "APPLIED SETTING: Dock: Recent Applications section hidden."

# When minimizing a window, collapse it into the app's own Dock icon instead of
# creating a separate thumbnail on the right side of the Dock. Retrieve minimized
# windows by right-clicking the app icon → Show All Windows, or clicking the icon
# when no window is currently open.
defaults write com.apple.dock minimize-to-application -bool true
echo "APPLIED SETTING: Dock: minimize-to-app-icon enabled."

# --- Finder ---

# Show hidden files (dot-prefixed: .zshrc, .git, .env, etc.).
# Essential for developer workflows — most Unix config files are hidden by default.
defaults write com.apple.finder AppleShowAllFiles -bool true
echo "APPLIED SETTING: Finder: hidden files shown."

# Column view: navigate folders as nested columns, each click drilling into a new
# column while keeping parent context visible.
# Alternatives: icnv=icon, Nlsv=list, Flwv=gallery.
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
echo "APPLIED SETTING: Finder: default view set to column."

# No grouping; sort by Date Modified. FXPreferredGroupBy controls group-by;
# FXArrangeGroupViewBy controls sort-by. "Date Modified" grouping adds date buckets
# (Today/Yesterday/Last 7 Days) — useful in icon/list view but noisy in column view.
defaults write com.apple.finder FXPreferredGroupBy -string "None"
echo "APPLIED SETTING: Finder: grouping disabled."
defaults write com.apple.finder FXArrangeGroupViewBy -string "Date Modified"
echo "APPLIED SETTING: Finder: sort order set to Date Modified."

# Status bar (item count + disk space at bottom of window).
defaults write com.apple.finder ShowStatusBar -bool true
echo "APPLIED SETTING: Finder: status bar enabled."

# Path bar (breadcrumb trail at bottom).
defaults write com.apple.finder ShowPathbar -bool true
echo "APPLIED SETTING: Finder: path bar enabled."

# Always show file extensions. Without this, macOS hides known extensions
# (e.g. "script" instead of "script.sh"), making file types ambiguous.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
echo "APPLIED SETTING: File extensions: always shown."

# Folders on top when sorting by name. Mirrors the convention used in VS Code,
# GitHub's file browser, and most IDEs. Disable if you prefer pure alphabetical
# (consistent with ls output).
defaults write com.apple.finder _FXSortFoldersFirst -bool true
echo "APPLIED SETTING: Finder: folders-on-top enabled."

# Search current folder by default, not the whole Mac. When you ⌘F in Finder,
# this scopes the search to the directory you're already in — far more useful
# when navigating a project than a global search.
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
echo "APPLIED SETTING: Finder: search scope set to current folder."

# Suppress the confirmation dialog when changing a file's extension.
# The warning is redundant once you understand what extensions do.
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
echo "APPLIED SETTING: Finder: file extension change warning disabled."

# NOTE: toolbar and preview pane have no top-level defaults key — they are stored
# per-window. Enable once manually: View > Show Toolbar, View > Show Preview (⇧⌘P).

# Prevent macOS from creating .DS_Store files on network volumes (SMB, AFP, NFS).
# .DS_Store stores folder view settings (icon positions, sort order) — harmless on local disk,
# but on shared volumes it pollutes other users' systems and can leak directory metadata
# (file and folder names are embedded in the file, readable by anyone with access).
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
echo "APPLIED SETTING: Finder: .DS_Store creation disabled on network volumes."

# Same for USB/external drives. Prevents hidden clutter on drives shared with
# Windows or Linux machines, which surface .DS_Store as visible mystery files.
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
echo "APPLIED SETTING: Finder: .DS_Store creation disabled on USB/external volumes."

# Open new Finder windows to the home folder instead of Recents. Recents is a
# virtual smart folder — it gives no sense of where files actually live on disk.
# NewWindowTarget and NewWindowTargetPath must be set together; they are one setting.
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
echo "APPLIED SETTING: Finder: new windows open to home folder (${HOME})."

# --- Typing ---

# Disable autocorrect. It silently rewrites words as you type — tolerable in prose,
# but it mangles variable names, hostnames, technical terms, and command syntax.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
echo "APPLIED SETTING: Typing: autocorrect disabled."

# Disable auto-capitalization. macOS uppercases the first word after punctuation,
# which breaks URLs, shell commands, and lowercase-first identifiers.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
echo "APPLIED SETTING: Typing: auto-capitalization disabled."

# Disable smart (curly) quote substitution. macOS replaces straight " and ' with
# typographic "curly" quotes — these are syntactically invalid in every programming
# language and silently break code copied from native text fields into a terminal or editor.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
echo "APPLIED SETTING: Typing: smart quote substitution disabled (straight quotes preserved)."

# Disable smart dash substitution. macOS replaces -- with an em dash (—) and
# a single - with an en dash (–) in some contexts. This breaks CLI flags
# (e.g. --verbose becomes —verbose) when typed or pasted from a native text field.
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
echo "APPLIED SETTING: Typing: smart dash substitution disabled (literal hyphens preserved)."

# Disable double-space → period substitution. Pressing space twice inserts a period,
# which is unexpected behavior outside of prose writing.
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
echo "APPLIED SETTING: Typing: double-space period substitution disabled."

# --- Save / Print Dialogs ---

# Expand the save dialog by default. macOS shows a compact sheet with only a filename
# field; you must click a small disclosure chevron to reveal the full folder browser.
# This makes the full browser the default so you always see where a file will be saved.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
echo "APPLIED SETTING: Save dialog: expanded by default."

# Some apps use a second save-mode state key; set it expanded for consistency.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
echo "APPLIED SETTING: Save dialog (mode 2): expanded by default."

# Expand the print dialog by default. Without this, the print sheet shows only
# basic options (copies, page range); you must click "Show Details" for the full panel.
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
echo "APPLIED SETTING: Print dialog: expanded by default."

# --- Screenshots ---

# Remove the drop shadow added to window screenshots (⌘⇧4 → Space to click a window).
# The shadow creates a semi-transparent halo that looks fine on dark backgrounds but
# leaves visible artifacts when pasted into docs, slides, or light-background pages.
defaults write com.apple.screencapture disable-shadow -bool true
echo "APPLIED SETTING: Screenshots: drop shadow disabled."

# Save screenshots as PNG. PNG is lossless — no compression artifacts on text or UI chrome.
# Already the default in modern macOS, but setting it explicitly prevents silent resets.
defaults write com.apple.screencapture type -string "png"
echo "APPLIED SETTING: Screenshots: format set to PNG (lossless)."

# --- TextEdit ---

# Open new documents in plain text mode instead of Rich Text (RTF). RTF embeds invisible
# formatting markup and saves as .rtf with binary metadata even for simple notes. Plain
# text creates .txt files — no hidden markup, works with any editor, grep-able, versionable.
defaults write com.apple.TextEdit RichText -int 0
echo "APPLIED SETTING: TextEdit: plain text mode enabled."

# Set the encoding for reading plain text files to UTF-8 (value 4). Without this,
# TextEdit may default to a legacy Mac encoding (Mac OS Roman), which corrupts
# non-ASCII characters — accents, emoji, and any non-Latin script.
defaults write com.apple.TextEdit PlainTextEncoding -int 4
echo "APPLIED SETTING: TextEdit: plain text read encoding set to UTF-8."

# Set the encoding for writing plain text files to UTF-8. Mirrors the read encoding
# so files round-trip cleanly without encoding mismatches.
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
echo "APPLIED SETTING: TextEdit: plain text write encoding set to UTF-8."

# --- Activity Monitor ---

# Show all processes on open, not just the current user's. Without this, system
# daemons and background tasks are hidden, making it harder to diagnose CPU spikes
# or memory pressure from processes you didn't launch yourself.
defaults write com.apple.ActivityMonitor ShowCategory -int 0
echo "APPLIED SETTING: Activity Monitor: all processes shown."

# Sort by CPU usage descending on open. The most common reason to open Activity
# Monitor is to find what's pegging the CPU; this surfaces it immediately without
# having to click the CPU column header.
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
echo "APPLIED SETTING: Activity Monitor: sorted by CPU usage."
defaults write com.apple.ActivityMonitor SortDirection -int 0
echo "APPLIED SETTING: Activity Monitor: sort direction set to descending."

# --- Menu Bar Clock ---

# Show the date and day of week in the menu bar (e.g. "Sat Jun 28 14:32:05").
# Useful when correlating with log timestamps or working across multiple time zones.
defaults write com.apple.menuextra.clock ShowDate -int 1
echo "APPLIED SETTING: Menu bar clock: date shown."
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
echo "APPLIED SETTING: Menu bar clock: day of week shown."

# Show seconds. Useful when timing operations by eye or matching log output
# to the exact second without opening a separate clock.
defaults write com.apple.menuextra.clock ShowSeconds -bool true
echo "APPLIED SETTING: Menu bar clock: seconds shown."

# --- Apply Changes ---

# Restart processes that hold settings in memory and won't pick them up until relaunched.
# ControlCenter manages the menu bar in macOS Monterey 12+ (replaced SystemUIServer).
killall Dock
echo "APPLIED SETTING: Dock restarted."
killall Finder
echo "APPLIED SETTING: Finder restarted."
killall ControlCenter
echo "APPLIED SETTING: ControlCenter restarted (menu bar clock and extras applied)."
