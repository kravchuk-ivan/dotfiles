defaults write com.apple.loginwindow DisableScreenLockImmediate -bool yes
echo "APPLIED SETTING: Disable lock button on magic keyboard (no touch-id) to prevent unintended locks."

defaults write com.apple.dock static-only -bool true; killall Dock
echo "APPLIED SETTING: Show only active apps in dock."
