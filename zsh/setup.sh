#!/usr/bin/env bash
# Keep a managed block at the top of ~/.zshrc that loads the shared config.
# Only the lines between the markers are ever written: everything else in
# ~/.zshrc (secrets, lines that installers append) is left as it is, and never
# printed. Safe to re-run. install.sh calls it.
#
#   ~/dotfiles/zsh/setup.sh             apply
#   ~/dotfiles/zsh/setup.sh --dry-run   show what would change
set -euo pipefail

ZSHRC="$HOME/.zshrc"
BEGIN='# >>> dotfiles >>>'
END='# <<< dotfiles <<<'

DRY_RUN=0
case "${1:-}" in
    "") ;;
    -n | --dry-run) DRY_RUN=1 ;;
    *) echo "usage: $0 [--dry-run]" >&2; exit 64 ;;
esac

note() { printf '    %s\n' "$*"; }

# The p10k lines live here rather than in zsh/zshrc because `p10k configure`
# only looks in ~/.zshrc, and adds its own copies of them when it can't find
# them there. The instant prompt has to come before anything else.
BLOCK=$(cat <<'EOF'
# >>> dotfiles >>>
# Written by ~/dotfiles/zsh/setup.sh, which replaces these lines on every run.
# Put secrets and machine-local lines below the block, never in the repo.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source "$HOME/dotfiles/zsh/zshrc"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# <<< dotfiles <<<
EOF
)
# What the old install.sh wrote to ~/.zshrc before the block existed. Removed
# outside the block only on an exact match, so lines that were edited or
# indented into an if/fi are left alone (and reported below instead).
LEGACY1='# Machine-local zsh config. The shared part is in ~/dotfiles/zsh/zshrc; keep'
LEGACY2='# secrets and machine-specific lines below, not in the public repo.'
LEGACY3='source "$HOME/dotfiles/zsh/zshrc"'
export BLOCK BEGIN END LEGACY1 LEGACY2 LEGACY3
NOT_LEGACY='$0 != ENVIRON["LEGACY1"] && $0 != ENVIRON["LEGACY2"] && $0 != ENVIRON["LEGACY3"]'

has() { grep -qxF "$1" "$ZSHRC" 2>/dev/null; }

tmp=$(mktemp)
rest=$(mktemp)
trap 'rm -f "$tmp" "$rest"' EXIT

unpaired() {
    note "~/.zshrc has a dotfiles marker without its pair, so it was left alone."
    note "  Fix or delete the marker line, then run this script again."
    exit 0
}

if has "$BEGIN" && has "$END"; then
    # Replace the first block in place and drop any further copies. Bail out
    # on a stray marker, which would otherwise drop the rest of the file.
    awk '
        $0 == ENVIRON["BEGIN"] { if (skip) exit 1; if (!done) print ENVIRON["BLOCK"]; done = 1; skip = 1; next }
        $0 == ENVIRON["END"] { if (!skip) exit 1; skip = 0; next }
        !skip && '"$NOT_LEGACY"'
        END { if (skip) exit 1 }
    ' "$ZSHRC" > "$tmp" || unpaired
elif has "$BEGIN" || has "$END"; then
    unpaired
else
    # Prepend, so the instant prompt runs first.
    [ ! -e "$ZSHRC" ] || awk "$NOT_LEGACY" "$ZSHRC" > "$rest"
    { printf '%s\n' "$BLOCK"; [ ! -s "$rest" ] || { echo; cat "$rest"; }; } > "$tmp"
fi

if cmp -s "$tmp" "$ZSHRC"; then
    note "~/.zshrc: dotfiles block up to date"
elif [ "$DRY_RUN" = 1 ]; then
    note "would update the dotfiles block in ~/.zshrc"
else
    if [ -e "$ZSHRC" ]; then
        backup="$ZSHRC.backup-$(date +%Y%m%d-%H%M%S)"
        cp -p "$ZSHRC" "$backup"
        chmod go-rwx "$backup"
        note "copied ~/.zshrc to $backup"
    fi
    # Write through the existing file, keeping its permissions (and its
    # target, if it's a symlink).
    cat "$tmp" > "$ZSHRC"
    note "~/.zshrc: dotfiles block updated"
fi

# ~/.zshrc holds secrets: readable by its owner only.
if [ -e "$ZSHRC" ]; then
    case "$(ls -lL "$ZSHRC")" in
        -???------*) ;;
        *)
            if [ "$DRY_RUN" = 1 ]; then
                note "would make ~/.zshrc readable by its owner only"
            else
                chmod go-rwx "$ZSHRC"
                note "~/.zshrc: made readable by its owner only"
            fi
            ;;
    esac
fi

# Copies of the block's lines elsewhere in the file (left by an older setup or
# by `p10k configure`) would run twice. Report them by line number only; they
# can't be removed safely by line, since some sit inside if/fi.
dups=$(awk '
    $0 == ENVIRON["BEGIN"] { skip = 1; next }
    skip && $0 == ENVIRON["END"] { skip = 0; next }
    !skip && /^[^#]*source[ \t].*(p10k-instant-prompt|\.p10k\.zsh|dotfiles\/zsh\/zshrc)/ { printf "%s%d", sep, NR; sep = ", " }
' "$tmp")
if [ -n "$dups" ]; then
    note "~/.zshrc also loads the dotfiles or p10k config outside the block, on"
    note "  line(s) $dups. Delete those lines (and any if/fi around them)."
fi
