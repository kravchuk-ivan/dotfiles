# Software productivity and ergonomics

## Global (any OS) (It is better to keep one readme file for all OS because it is faster to update and easier to see how to take the best out of all the OS's)

### Google Chrome browser extensions

- Vimium C Chrome extension: [vimium c user options](vimium-c-options.json)
- PDF Viewer for Vimium C
- uBlock Origin (adblocker): [whitelist for an adblocker](Whitelist-adblocker.txt)
- Keep one pinned tab
- 1Password
- Google dictionary (by Google)
- Good word guide (dictionary)
- Eye Dropper (color picker)
- Wappalyzer (identify web technologies)

### Terminal

- ohmyzsh
- tldr pages
- autojump
- gdu (terminal tools, disk usage analyzer)
- bpytop++
- pgcli (postgres client that does auto-completion and syntax highlighting)
- HTTPie

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

  - Open Hyperterminal at a finder folder (Apple script) [open-terminal-tabs-at-folder-control-option-command-t](/Users/johannesich/Desktop/softeng/psoftergonomics/open-terminal-tabs-at-folder-control-option-command-t/hyper):
    `right_control command option t`
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
- [VS Code user settings](vs-code-user-settings.json)
- [VS Code user keybindings](vs-code-user-keybindings.json)
- [hyperterminal user settings](hyperterminal.js)
- [zshrc config file](zshrc.zshrc)
- hammerspoon (macOS automation tool)
- amethyst (window manager, not bad and not great)
- amphetamine (keep-awake software)
- WhichSpace (to see the current screen in the menubar)
- yabai (powerful macOS window manager, the SIP should be disabled to use all the features)
- skhd
- stackline (visualize window stacks)
- Flycut (multiple clipboard manager)

## Windows

### Desktop and Windows management

3 Desktops. `Desktop 2` is the main desktop and is located in the center.
`Desktop 1` and `Desktop 3` are the complementary desktops for the uses we will come up with later.

### Programs, software

## Linux