# Software productivity and ergonomics

## Global (any OS)

### Google Chrome browser extensions

- Vimium C Chrome extension: [vimium c user options](vimium-c.json)
- PDF Viewer for Vimium C
- uBlock Origin (adblocker): [whitelist for an adblocker](whitelist-adblocker.txt)
- 1Password
- Google dictionary (by Google)
- Eye Dropper (color picker)

### Terminal

- ohmyzsh
- tldr pages

## Linux

## Windows

- voidtools: Everything (better search)
- Powertoys
- Autohotkey
- Windows Terminal

## macOS

- **Enhance the performance of your mac keyboard:**

  1. Enable repeating keys:
     `defaults write -g ApplePressAndHoldEnabled -bool false`
  2. Change key repeat rate to 1 from 2 (normal minimum):
     `defaults write -g KeyRepeat -int 1`
  3. Change initial key repeat rate from **15** (standard minimum) to **10** (lower than 10 is too fast and error prone):
     `defaults write -g InitialKeyRepeat -int 10`

- **Change trackpad speed to maximum:**
  `defaults write -g com.apple.mouse.scaling -float 5.0`
- **Use column view in all Finder windows by default:**
  open a finder window -> view options -> always column view, also browse in column view
- **Show only active apps in dock:** 
  `defaults write com.apple.dock static-only -bool true; killall Dock`
- **Apple shortcuts (preferences->shortcuts):**
  - "search-in-google-chrome" shortcut. (Apple Script using ruby). Search selected or clipboard text in Google Chrome.
    Shell (zsh/bash) script:
    `"open "http://www.google.com/search?q=$(ruby -rcgi -e 'print CGI.escape $<.read.chomp')"`
    Shortcut:
    `control command ;`
  - "Look Up in Dictionary"  
    `control ;`
  - Switch to the next window
    `control command g`
  - Switch to desktop 1
    `command control 3`
  - Switch to desktop 2
    `command control 4`

- [Karabiner Elements Pro/Guest user keyboard configurations](karabiner-keyboard-remappings.json)
- hammerspoon (macOS automation tool)
- amphetamine (keep-awake software)
- WhichSpace (to see the current screen in the menubar)
- yabai (powerful macOS window manager, the SIP should be disabled to use all the features)
- skhd
- stackline (visualize window stacks)
- Flycut (multiple clipboard manager)

### Desktop and Windows management

### Programs, software
