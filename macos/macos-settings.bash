defaults write com.apple.loginwindow DisableScreenLockImmediate -bool yes
echo "APPLIED SETTING: Disable lock button on magic keyboard (no touch-id) to prevent unintended locks."

defaults write com.apple.dock static-only -bool true; killall Dock
echo "APPLIED SETTING: Show only active apps in dock."

defaults write -g ApplePressAndHoldEnabled -bool false
echo "GLOBAL: APPLIED SETTING: Enable repeating keys across the applications."

alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
echo "APPLIED SETTING: Show hidden files in finder."
