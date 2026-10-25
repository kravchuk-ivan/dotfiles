# Installed by install.sh with `brew bundle`.

# Command-line tools
brew "bat"
brew "fd"
brew "fzf"
brew "gh"
brew "htop"
brew "neovim"
brew "powerlevel10k"
brew "powershell"
brew "ripgrep"
brew "tldr"
brew "tree"
brew "vifm"
brew "wget"
brew "whois"

# Fonts: SF Mono for iTerm2 and VS Code
cask "font-jetbrains-mono"
cask "font-sf-mono"

# Apps. Installing a cask over an app that is already there (installed by
# hand, or pushed by MDM on a work Mac) fails, so those are skipped.
def app(token, bundle)
  cask token unless File.exist?("/Applications/#{bundle}")
end

app "1password",            "1Password.app"
app "antigravity",          "Antigravity.app"
app "bruno",                "Bruno.app"
app "claude",               "Claude.app"
app "drawio",               "draw.io.app"
app "firefox",              "Firefox.app"
app "google-chrome",        "Google Chrome.app"
app "google-chrome@canary", "Google Chrome Canary.app"
app "google-drive",         "Google Drive.app"
app "grammarly-desktop",    "Grammarly Desktop.app"
app "iterm2",               "iTerm.app"
app "karabiner-elements",   "Karabiner-Elements.app"
app "microsoft-teams",      "Microsoft Teams.app"
app "obsidian",             "Obsidian.app"
app "postman",              "Postman.app"
app "rectangle",            "Rectangle.app"
app "slack",                "Slack.app"
app "sublime-text",         "Sublime Text.app"
app "todoist-app",          "Todoist.app"
app "visual-studio-code",   "Visual Studio Code.app"
app "vlc",                  "VLC.app"
app "zoom",                 "zoom.us.app"
