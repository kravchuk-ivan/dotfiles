defaults write com.apple.loginwindow DisableScreenLockImmediate -bool yes
echo "APPLIED SETTING: Disable lock button on magic keyboard (no touch-id) to prevent unintended locks."

# Hide all pinned/persistent app icons; show only currently running apps.
# Keeps the Dock minimal — you launch apps via Spotlight, not the Dock.
defaults write com.apple.dock static-only -bool true
echo "APPLIED SETTING: Dock shows only running apps (pinned icons hidden)."

# Hide the "Recent Applications" cluster that appears after the Dock divider.
# Without this, macOS still shows the last 3 opened apps even with static-only=true.
defaults write com.apple.dock show-recents -bool false
echo "APPLIED SETTING: Dock hides the Recent Applications section."

# When minimizing a window, collapse it into the app's own Dock icon instead of
# creating a separate thumbnail on the right side of the Dock. Retrieve minimized
# windows by right-clicking the app icon → Show All Windows, or clicking the icon
# when no window is currently open.
defaults write com.apple.dock minimize-to-application -bool true
echo "APPLIED SETTING: Minimized windows collapse into their app's Dock icon."

killall Dock
echo "APPLIED SETTING: Restarted Dock to apply changes."

# Disable the press-and-hold popup (accented character picker) and enable key repeat
# instead. Without this, holding a key shows a picker rather than repeating the character —
# which makes arrow-key navigation and backspace sluggish in every app.
defaults write -g ApplePressAndHoldEnabled -bool false
echo "APPLIED SETTING: Key repeat enabled (press-and-hold accent picker disabled)."

# How fast a held key fires after the initial delay. The System Settings slider exposes
# values from 2 (Fast) to 120 (Slow); default is ~6. Setting 2 = fastest in the UI range.
defaults write NSGlobalDomain KeyRepeat -int 2
echo "APPLIED SETTING: Key repeat rate set to 2 (maximum within System Settings range)."

# How long you must hold a key before it starts repeating. The System Settings slider
# exposes values from 15 (Short) to 120 (Long); default is ~25. Setting 15 = shortest in range.
defaults write NSGlobalDomain InitialKeyRepeat -int 15
echo "APPLIED SETTING: Initial key repeat delay set to 15 (minimum within System Settings range)."

defaults write com.apple.finder AppleShowAllFiles -bool true
echo "APPLIED SETTING: Show hidden files in Finder."

# --- Finder UI ---

# Column view (clmv). Alternatives: icnv=icon, Nlsv=list, Flwv=gallery.
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
echo "APPLIED SETTING: Finder default view: column."

# No grouping; sort by Date Modified.
# FXPreferredGroupBy controls group-by; FXArrangeGroupViewBy controls sort-by.
# "Date Modified" grouping adds date buckets (Today/Yesterday/Last 7 Days) —
# useful in icon/list view but adds visual noise in column view.
defaults write com.apple.finder FXPreferredGroupBy -string "None"
defaults write com.apple.finder FXArrangeGroupViewBy -string "Date Modified"
echo "APPLIED SETTING: Finder sort by Date Modified, no grouping."

# Status bar (item count + disk space at bottom of window).
defaults write com.apple.finder ShowStatusBar -bool true
echo "APPLIED SETTING: Finder status bar visible."

# Path bar (breadcrumb trail at bottom).
defaults write com.apple.finder ShowPathbar -bool true
echo "APPLIED SETTING: Finder path bar visible."

# Always show file extensions.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
echo "APPLIED SETTING: Always show file extensions."

# Folders on top when sorting by name.
defaults write com.apple.finder _FXSortFoldersFirst -bool true
echo "APPLIED SETTING: Folders on top when sorting by name."

# Search current folder by default, not whole Mac.
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
echo "APPLIED SETTING: Finder searches current folder by default."

# No warning when changing a file extension.
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
echo "APPLIED SETTING: Disabled file extension change warning."

# NOTE: toolbar and preview pane have no top-level defaults key — they are stored
# per-window. Enable once manually: View > Show Toolbar, View > Show Preview (⇧⌘P).

# Prevent macOS from creating .DS_Store files on network volumes (SMB, AFP, NFS).
# .DS_Store stores folder view settings (icon positions, sort order) — harmless on local disk,
# but on shared volumes it pollutes other users' systems and can leak directory metadata
# (file and folder names are embedded in the file, readable by anyone with access).
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
echo "APPLIED SETTING: .DS_Store creation disabled on network volumes."

# Same for USB/external drives. Prevents hidden clutter on drives shared with
# Windows or Linux machines, which surface .DS_Store as visible mystery files.
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
echo "APPLIED SETTING: .DS_Store creation disabled on USB/external volumes."

# Open new Finder windows to the home folder instead of Recents. Recents is a
# virtual smart folder — it gives no sense of where files actually live on disk
# and makes navigating to a real location require an extra step. Home folder is
# a predictable, real starting point. NewWindowTargetPath must match NewWindowTarget.
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
echo "APPLIED SETTING: New Finder windows open to home folder (${HOME})."

killall Finder
echo "APPLIED SETTING: Restarted Finder to apply changes."

# --- Typing ---

# Disable autocorrect. It silently rewrites words as you type — tolerable in prose,
# but it mangles variable names, hostnames, technical terms, and command syntax.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
echo "APPLIED SETTING: Autocorrect disabled."

# Disable auto-capitalization. macOS uppercases the first word after punctuation,
# which breaks URLs, shell commands, and lowercase-first identifiers.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
echo "APPLIED SETTING: Auto-capitalization disabled."

# Disable smart (curly) quote substitution. macOS replaces straight " and ' with
# typographic "curly" quotes — these are syntactically invalid in every programming
# language and silently break code copied from native text fields into a terminal or editor.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
echo "APPLIED SETTING: Smart quote substitution disabled (straight quotes preserved)."

# Disable smart dash substitution. macOS replaces -- with an em dash (—) and
# a single - with an en dash (–) in some contexts. This breaks CLI flags
# (e.g. --verbose becomes —verbose) when typed or pasted from a native text field.
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
echo "APPLIED SETTING: Smart dash substitution disabled (literal hyphens preserved)."

# Disable double-space → period substitution. Pressing space twice inserts a period,
# which is unexpected behavior outside of prose writing.
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
echo "APPLIED SETTING: Double-space period substitution disabled."

# --- Save / Print Dialogs ---

# Expand the save dialog by default. macOS shows a compact sheet with only a filename
# field; you must click a small disclosure chevron to reveal the full folder browser.
# This makes the full browser the default so you always see where a file will be saved.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
echo "APPLIED SETTING: Save dialog opens expanded (full folder browser visible)."

# Some apps use a second save-mode state key; set it expanded for consistency.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
echo "APPLIED SETTING: Save dialog (mode 2) opens expanded."

# Expand the print dialog by default. Without this, the print sheet shows only
# basic options (copies, page range); you must click "Show Details" for the full panel.
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
echo "APPLIED SETTING: Print dialog opens expanded (all options visible by default)."

# --- Screenshots ---

# Remove the drop shadow added to window screenshots (⌘⇧4 → Space to click a window).
# The shadow creates a semi-transparent halo that looks fine on dark backgrounds but
# leaves visible artifacts when pasted into docs, slides, or light-background pages.
defaults write com.apple.screencapture disable-shadow -bool true
echo "APPLIED SETTING: Window screenshots captured without drop shadow."

# Save screenshots as PNG. PNG is lossless — no compression artifacts on text or UI chrome.
# Already the default in modern macOS, but setting it explicitly prevents silent resets.
defaults write com.apple.screencapture type -string "png"
echo "APPLIED SETTING: Screenshots saved as PNG (lossless)."

# --- TextEdit ---

# Open new documents in plain text mode instead of Rich Text (RTF). RTF embeds invisible
# formatting markup and saves as .rtf with binary metadata even for simple notes. Plain
# text creates .txt files — no hidden markup, works with any editor, grep-able, versionable.
defaults write com.apple.TextEdit RichText -int 0
echo "APPLIED SETTING: TextEdit opens new documents in plain text mode."

# Set the encoding for reading plain text files to UTF-8 (value 4). Without this,
# TextEdit may default to a legacy Mac encoding (Mac OS Roman), which corrupts
# non-ASCII characters — accents, emoji, and any non-Latin script.
defaults write com.apple.TextEdit PlainTextEncoding -int 4
echo "APPLIED SETTING: TextEdit reads plain text files as UTF-8."

# Set the encoding for writing plain text files to UTF-8. Mirrors the read encoding
# so files round-trip cleanly without encoding mismatches.
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
echo "APPLIED SETTING: TextEdit writes plain text files as UTF-8."

# --- Trackpad ---

# Tap to click: register a light tap (no physical click force) as a left click.
# Reduces finger fatigue vs. pressing the physical trackpad for every action.
# Must be written to three domains: the built-in trackpad driver, the Bluetooth
# trackpad driver, and the global mouse behavior key that apps read to honor it.
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
echo "APPLIED SETTING: Tap-to-click enabled (built-in trackpad driver)."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
echo "APPLIED SETTING: Tap-to-click enabled (Bluetooth trackpad driver)."
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
echo "APPLIED SETTING: Tap-to-click enabled (global mouse behavior)."

# Three-finger drag: drag windows and select text by sliding three fingers across
# the trackpad surface — no click-and-hold required. More ergonomic for long
# movements. Potential overlap with three-finger swipe gestures (Mission Control,
# app exposé) is resolved by macOS context: a drag only begins when fingers land
# on a draggable surface, so conflicts are rare in practice.
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
echo "APPLIED SETTING: Three-finger drag enabled (built-in trackpad driver)."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
echo "APPLIED SETTING: Three-finger drag enabled (Bluetooth trackpad driver)."

# --- Activity Monitor ---

# Show all processes on open, not just the current user's. Without this, system
# daemons and background tasks are hidden, making it harder to diagnose CPU spikes
# or memory pressure from processes you didn't launch yourself.
defaults write com.apple.ActivityMonitor ShowCategory -int 0
echo "APPLIED SETTING: Activity Monitor shows all processes."

# Sort by CPU usage descending on open. The most common reason to open Activity
# Monitor is to find what's pegging the CPU; this surfaces it immediately without
# having to click the CPU column header.
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
echo "APPLIED SETTING: Activity Monitor sorted by CPU usage."
defaults write com.apple.ActivityMonitor SortDirection -int 0
echo "APPLIED SETTING: Activity Monitor sort direction: descending."

# --- Menu Bar Clock ---

# Show the date and day of week in the menu bar (e.g. "Sat Jun 28 14:32:05").
# Useful when correlating with log timestamps or working across multiple time zones.
defaults write com.apple.menuextra.clock ShowDate -int 1
echo "APPLIED SETTING: Menu bar clock shows date."
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
echo "APPLIED SETTING: Menu bar clock shows day of week."

# Show seconds. Useful when timing operations by eye or matching log output
# to the exact second without opening a separate clock.
defaults write com.apple.menuextra.clock ShowSeconds -bool true
echo "APPLIED SETTING: Menu bar clock shows seconds."

killall SystemUIServer
echo "APPLIED SETTING: Restarted SystemUIServer to apply menu bar changes."

# --- System ---

# Full keyboard access: Tab cycles through ALL interactive UI controls — buttons,
# checkboxes, radio buttons, sliders — not just text fields and lists (the default).
# Without this, confirmation dialogs require a mouse click on a button even when
# Tab is available. With it, Tab focuses the button and Space activates it,
# making keyboard-only flows possible in native macOS dialogs.
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
echo "APPLIED SETTING: Full keyboard access enabled (Tab navigates all UI controls)."
