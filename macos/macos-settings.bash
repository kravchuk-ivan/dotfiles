defaults write com.apple.loginwindow DisableScreenLockImmediate -bool yes
echo "APPLIED SETTING: Disable lock button on magic keyboard (no touch-id) to prevent unintended locks."

defaults write com.apple.dock static-only -bool true; killall Dock
echo "APPLIED SETTING: Show only active apps in dock."

defaults write -g ApplePressAndHoldEnabled -bool false
echo "GLOBAL: APPLIED SETTING: Enable repeating keys across the applications."

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

killall Finder
echo "APPLIED SETTING: Restarted Finder to apply changes."
