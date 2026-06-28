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
