#!/usr/bin/env bash
# Set up a Mac from this repo: Homebrew packages and apps, config symlinks,
# macOS and app preferences, and a security check. Safe to re-run: steps that
# are already done are skipped, and any file it replaces is moved aside to
# <name>.backup-<timestamp> first.
#
#   ~/dotfiles/install.sh             apply everything
#   ~/dotfiles/install.sh --dry-run   show what would change, change nothing
#
# `source ~/dotfiles/install.sh` works too, from zsh or bash.

# When sourced, re-run in a child bash so `set -e` and bash syntax never touch
# the calling shell.
if [ -n "${ZSH_VERSION:-}" ]; then
    bash "$0" "$@"; return $?            # zsh sets $0 to the sourced file
elif [ "${BASH_SOURCE[0]}" != "$0" ]; then
    bash "${BASH_SOURCE[0]}" "$@"; return $?
fi

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"
APP_SUPPORT="$HOME/Library/Application Support"

DRY_RUN=0
case "${1:-}" in
    "") ;;
    -n | --dry-run) DRY_RUN=1 ;;
    *) echo "usage: $0 [--dry-run]" >&2; exit 64 ;;
esac

step() { printf '\n==> %s\n' "$*"; }
note() { printf '    %s\n' "$*"; }
run() {
    if [ "$DRY_RUN" = 1 ]; then note "would run: $*"; else "$@"; fi
}
# Report a change that was made (silent in a dry run, where run already said it).
did() { [ "$DRY_RUN" = 1 ] || note "$@"; }

# Move an existing file, directory or link out of the way.
backup() {
    [ -e "$1" ] || [ -L "$1" ] || return 0
    run mv "$1" "$1.backup-$STAMP"
    did "moved existing $1 to $1.backup-$STAMP"
}

# link <path in repo> <target>: make target a symlink to the repo copy.
link() {
    local src="$DOTFILES/$1" dst="$2"
    [ "$(readlink "$dst" 2>/dev/null || true)" = "$src" ] && return 0
    backup "$dst"
    run mkdir -p "$(dirname "$dst")"
    run ln -s "$src" "$dst"
    did "linked $dst"
}

# append_line <file> <line>: add the line unless the file already has it.
append_line() {
    grep -qsxF "$2" "$1" && return 0
    if [ "$DRY_RUN" = 1 ]; then note "would add to $1: $2"; else printf '%s\n' "$2" >> "$1"; fi
    did "added to $1: $2"
}

running() { pgrep -xq "$1"; }

[ "$(uname -s)" = Darwin ] || { echo "install.sh is for macOS" >&2; exit 1; }
[ "$(id -u)" != 0 ] || { echo "run install.sh as your user, not root" >&2; exit 1; }
if [ "$DOTFILES" != "$HOME/dotfiles" ]; then
    note "warning: zshrc and the Karabiner rules expect this repo at ~/dotfiles"
fi
[ "$DRY_RUN" = 1 ] && note "dry run: nothing will be changed"

step "Xcode Command Line Tools"
if xcode-select -p >/dev/null 2>&1; then
    note "installed"
else
    run xcode-select --install
    echo "Finish the Command Line Tools installer, then run install.sh again."
    exit 1
fi

step "Homebrew"
if ! command -v brew >/dev/null && [ ! -x /opt/homebrew/bin/brew ]; then
    run /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
if command -v brew >/dev/null; then
    run brew analytics off
    run brew bundle --file="$DOTFILES/Brewfile" || note "some Brewfile entries failed; see the output above"
fi

step "Shell"
# Cloned rather than run through the installers: the oh-my-zsh installer
# rewrites ~/.zshrc and the nvm one appends to it.
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    run git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi
if [ ! -d "$HOME/.nvm" ]; then
    run git clone https://github.com/nvm-sh/nvm.git "$HOME/.nvm"
    if [ "$DRY_RUN" = 0 ]; then
        git -C "$HOME/.nvm" checkout -q "$(git -C "$HOME/.nvm" describe --abbrev=0 --tags --match 'v[0-9]*' "$(git -C "$HOME/.nvm" rev-list --tags --max-count=1)")"
    fi
fi
if [ ! -d "$HOME/.nvm/versions/node" ]; then
    if [ "$DRY_RUN" = 1 ]; then
        note "would run: nvm install --lts"
    else
        (set +eu; . "$HOME/.nvm/nvm.sh" && nvm install --lts) || note "nvm install --lts failed; run it in a new shell"
    fi
fi

# ~/.zshrc stays machine-local: installers append to it and secrets go there.
# It only sources the shared config.
if ! grep -qs 'dotfiles/zsh/zshrc' "$HOME/.zshrc"; then
    backup "$HOME/.zshrc"
    if [ "$DRY_RUN" = 1 ]; then
        note "would write $HOME/.zshrc"
    else
        cat > "$HOME/.zshrc" <<'EOF'
# Machine-local zsh config. The shared part is in ~/dotfiles/zsh/zshrc; keep
# secrets and machine-specific lines below, not in the public repo.
source "$HOME/dotfiles/zsh/zshrc"
EOF
        did "wrote $HOME/.zshrc"
    fi
fi
link zsh/p10k.zsh "$HOME/.p10k.zsh"

step "Config files"
link nvim/init.vim                          "$HOME/.config/nvim/init.vim"
link nvim/coc-settings.json                 "$HOME/.config/nvim/coc-settings.json"
link vifmrc                                 "$HOME/.config/vifm/vifmrc"
link git/ignore                             "$HOME/.config/git/ignore"
link macos/karabiner                        "$HOME/.config/karabiner"
link sublime/Preferences.sublime-settings   "$APP_SUPPORT/Sublime Text/Packages/User/Preferences.sublime-settings"
link "sublime/Package Control.sublime-settings" "$APP_SUPPORT/Sublime Text/Packages/User/Package Control.sublime-settings"
link vs-code/settings.json                  "$APP_SUPPORT/Code/User/settings.json"
link vs-code/keybindings.json               "$APP_SUPPORT/Code/User/keybindings.json"
link macos/iterm/dotfiles-profile.json      "$APP_SUPPORT/iTerm2/DynamicProfiles/dotfiles-profile.json"

# ~/.gitconfig stays machine-local (work identities, credential helpers) and
# includes the shared settings.
if ! git config --global --get-all include.path 2>/dev/null | grep -qxF "$DOTFILES/git/config"; then
    run git config --global --add include.path "$DOTFILES/git/config"
    did "included git/config from ~/.gitconfig"
fi
# This repo's commit-msg and secret-scanning hooks.
run git -C "$DOTFILES" config core.hooksPath git/hooks
# npm skips package versions published less than 7 days ago, so a hijacked
# release is usually caught before it gets installed here.
append_line "$HOME/.npmrc" "min-release-age=7"

step "App preferences"
# iTerm2 rewrites its preferences on quit, so only write them while it's closed.
if running iTerm2; then
    note "iTerm2 is running: quit it and run install.sh again to apply its settings"
else
    guid=$(sed -n 's/.*"Guid": "\(.*\)".*/\1/p' "$DOTFILES/macos/iterm/dotfiles-profile.json")
    run defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$guid"
    # Security fixes ship as iTerm2 point releases.
    run defaults write com.googlecode.iterm2 SUEnableAutomaticChecks -bool true
    # Otherwise the last copied/pasted values, secrets included, are saved to disk.
    run defaults write com.googlecode.iterm2 SavePasteHistory -bool false
    did "iTerm2: dotfiles profile is the default; update checks on; paste history off"
fi

# Rectangle imports this file once at launch and then renames it, so only
# drop it in when Rectangle has no settings yet.
if ! defaults read com.knollsoft.Rectangle >/dev/null 2>&1; then
    run mkdir -p "$APP_SUPPORT/Rectangle"
    run cp "$DOTFILES/macos/rectangle-config.json" "$APP_SUPPORT/Rectangle/RectangleConfig.json"
    did "Rectangle: config will be imported at its next launch"
fi

code="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
if [ -x "$code" ]; then
    installed=$("$code" --list-extensions 2>/dev/null || true)
    while IFS= read -r ext; do
        [ -n "$ext" ] || continue
        printf '%s\n' "$installed" | grep -qixF "$ext" || run "$code" --install-extension "$ext"
    done < "$DOTFILES/vs-code/extensions.txt"
    did "VS Code: extensions from vs-code/extensions.txt installed"
fi

pc="$APP_SUPPORT/Sublime Text/Installed Packages/Package Control.sublime-package"
if [ -d "/Applications/Sublime Text.app" ] && [ ! -f "$pc" ]; then
    run mkdir -p "$(dirname "$pc")"
    run curl -fsSL -o "$pc" https://github.com/wbond/package_control/releases/latest/download/Package.Control.sublime-package
    did "Sublime Text: Package Control installed; it installs the listed packages on next launch"
fi

# chrome://flags aren't synced by Chrome Sync. They live in Local State, which
# Chrome rewrites on quit, and which only exists after Chrome's first launch.
#   extensions-on-chrome-urls / -extension-urls: let Vimium C work on chrome:// pages
#   extensions-menu-access-control@1: per-site extension access in the toolbar menu
local_state="$APP_SUPPORT/Google/Chrome/Local State"
if running "Google Chrome"; then
    note "Chrome is running: quit it and run install.sh again to set its flags"
elif [ -f "$local_state" ]; then
    if [ "$DRY_RUN" = 1 ]; then
        note "would set chrome://flags in $local_state"
    else
        python3 - "$local_state" <<'EOF'
import json, sys
flags = ["extensions-on-chrome-urls", "extensions-on-extension-urls", "extensions-menu-access-control@1"]
path = sys.argv[1]
state = json.load(open(path))
current = state.setdefault("browser", {}).setdefault("enabled_labs_experiments", [])
state["browser"]["enabled_labs_experiments"] = current + [f for f in flags if f not in current]
json.dump(state, open(path, "w"))
EOF
        did "Chrome: flags set"
    fi
elif [ -d "/Applications/Google Chrome.app" ]; then
    note "Chrome: open and quit it once, then run install.sh again to set its flags"
fi

step "macOS settings"
run bash "$DOTFILES/macos/macos-settings.bash"

step "Security check"
if [ "$DRY_RUN" = 1 ]; then
    bash "$DOTFILES/macos/security-check.sh" --check
else
    bash "$DOTFILES/macos/security-check.sh"
fi

step "Left to do by hand"
cat <<'EOF'
    - Karabiner-Elements: open it, allow its driver and Input Monitoring in
      System Settings, then quit and reopen it so it loads the linked config.
    - Secrets (API keys): add them to ~/.zshrc below the source line, or keep
      them in the Keychain:
        security add-generic-password -a "$USER" -s anthropic-api-key -w
        export ANTHROPIC_API_KEY="$(security find-generic-password -s anthropic-api-key -w)"
    - Work git identity: add an includeIf block to ~/.gitconfig.
    - Chrome: sign in to sync bookmarks, extensions and Vimium C settings; load
      chrome-extensions/instagram-auto-logout via chrome://extensions >
      Developer mode > Load unpacked.
    - Not in the Brewfile: Griply (no cask), Claude Code
      (curl -fsSL https://claude.ai/install.sh | bash).
    - System Settings: Accessibility > Display > Reduce motion; screenshot
      location (Cmd-Shift-5 > Options); keyboard shortcuts you turned off.
    - Restart, or log out and in, so every preference takes effect.
EOF
