# dotfiles

Personal dotfiles across operating systems and devices: keyboard
remappings, terminal and editor configuration, Chromium browser
configuration and automations, shortcuts, and more.

## New Mac

```sh
xcode-select --install          # git, then wait for the installer to finish
git clone https://github.com/kravchuk-ivan/dotfiles.git ~/dotfiles
~/dotfiles/install.sh --dry-run # preview
~/dotfiles/install.sh           # or: source ~/dotfiles/install.sh
```

`install.sh` installs Homebrew and everything in the `Brewfile`, links the
configs into place (moving anything it replaces to `<name>.backup-<timestamp>`),
applies the macOS and app settings, runs `macos/security-check.sh`, and ends
with a short list of steps that need a person (permissions, sign-ins, secrets).
It is safe to re-run.

The repo must live at `~/dotfiles`: the zsh config and Karabiner rules refer to
that path.

## Machine-local files

These stay out of the repo, which is public:

- `~/.zshrc` only sources `zsh/zshrc`. Put API keys and anything
  machine-specific below that line (or in the Keychain).
- `~/.gitconfig` includes `git/config`. Work identities (`includeIf`) and
  credential helpers go there.

The repo's `pre-commit` hook rejects commits that look like they contain a key
or token.

## Other platforms and apps

Setup steps for components `install.sh` doesn't cover (Windows, WSL, Obsidian
vault settings, Vimium C) are in comment blocks within the files themselves
and/or in a README in their own directory.

The commit convention and color-scheme rationale are defined in `CLAUDE.md`.
