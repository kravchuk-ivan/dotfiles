#!/bin/bash

###
# Put the following snippet into your shell configuration file ('.bashrc', '.zshrc', etc)

# Use $HOME instead of '~' sign (cross-platform)
# if [[ -f $HOME/sf/bash_aliases ]]
# then
#     source $HOME/sf/bash_aliases
# else
#     echo "[ERROR]:'$HOME/sf/bash_aliases' was not found."
# fi
###

# Functions
j() {
    cd "$@" && ls -Alh;
}
jj() {
    cd .. && ls -Alh;
}
jjj() {
    cd ../.. && ls -Alh;
}
jjjj() {
    cd ../../.. && ls -Alh;
}
jjjjj() {
    cd ../../../.. && ls -Alh;
}
jjjjjj() {
    cd ../../../../.. && ls -Alh;
}

# Make a directory and cd to it
mcd() {
    test -d "$1" || mkdir "$1" && cd "$1"
}

set -o vi

# General aliases
alias j-='j -'
alias jsd="j $HOME/sd" ;
alias jsf="j $HOME/sf" ;
alias jtmp="j $HOME/tmp" ;
alias k='nvim'
alias l='ls -Alh'
alias s='fzf'
alias d='vifm . .'

# OS-specific aliases
case "$OSTYPE" in
    linux-gnu*)
        # WSL2 Ubuntu
        alias apt-update='sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade' ;
        alias jwr="j /mnt/c/" ;
        alias jwh="j /mnt/c/Users/ivankravchuk99/" ;
        alias jdl="cd /mnt/c/Users/ivankravchuk99/Downloads && ls -Alhtr" ;
        alias jdt="j /mnt/c/Users/ivankravchuk99/Desktop" ;
        alias jpd="j /mnt/c/Users/ivankravchuk99/Google\ Drive/" ;
        alias cpwd='pwd | clip.exe && echo "COPIED " ; echo $PWD ; echo " to Windows system clipboard!" || echo \"[ERROR]: Could not copy the absolute path!\"' ;
        catcp() {
            test -f "$1" && cat "$1" | clip.exe
        }
    ;;
    darwin*)
        alias brew-update="brew update && brew upgrade" ;
        alias jdl="cd $HOME/Downloads && ls -Alhtr" ;
        alias jdt="j $HOME/Desktop" ;
        alias jpd="j $HOME/Desktop/pdrive" ;
        alias cpwd='pwd | pbcopy && echo "COPIED " ; echo $PWD ; echo " to macOS clipboard!" || echo \"[ERROR]: Could not copy the absolute path!\"' ;
        catcp() {
            test -f "$1" && pbcopy < "$1" && cat "$1"
        }
    ;;
    msys*)
        alias jwr="j /c/" ;
        alias jdl="cd /c/Users/ivankravchuk99/Downloads && ls -Alhtr" ;
        alias jdt="j /c/Users/ivankravchuk99/Desktop" ;
    ;;
    bsd*)
    ;;
    cygwin*)
    ;;
    *)
        echo "WARNING: there are no configurations specified for $OSTYPE"
    ;;
esac

## git aliases (you can also [include] path in $HOME/.gitconfig)
if [[ ! -d "$HOME/.oh-my-zsh" ]]
then
    alias g=git
    alias ga='git add'
    alias gaa='git add --all'
    alias gam='git am'
    alias gama='git am --abort'
    alias gamc='git am --continue'
    alias gams='git am --skip'
    alias gamscp='git am --show-current-patch'
    alias gap='git apply'
    alias gapa='git add --patch'
    alias gapt='git apply --3way'
    alias gau='git add --update'
    alias gav='git add --verbose'
    alias gb='git branch'
    alias gbD='git branch -D'
    alias gba='git branch -a'
    alias gbd='git branch -d'
    alias gbda='git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch -d 2>/dev/null'
    alias gbl='git blame -b -w'
    alias gbnm='git branch --no-merged'
    alias gbr='git branch --remote'
    alias gbs='git bisect'
    alias gbsb='git bisect bad'
    alias gbsg='git bisect good'
    alias gbsr='git bisect reset'
    alias gbss='git bisect start'
    alias gc='git commit -v'
    alias gca='git commit -v -a'
    alias gcam='git commit -a -m'
    alias gcas='git commit -a -s'
    alias gcasm='git commit -a -s -m'
    alias gcb='git checkout -b'
    alias gcd='git checkout $(git_develop_branch)'
    alias gcf='git config --list'
    alias gcl='git clone --recurse-submodules'
    alias gclean='git clean -id'
    alias gcm='git checkout $(git_main_branch)'
    alias gcmsg='git commit -m'
    alias gco='git checkout'
    alias gcor='git checkout --recurse-submodules'
    alias gcount='git shortlog -sn'
    alias gcp='git cherry-pick'
    alias gcpa='git cherry-pick --abort'
    alias gcpc='git cherry-pick --continue'
    alias gcs='git commit -S'
    alias gcsm='git commit -s -m'
    alias gcss='git commit -S -s'
    alias gcssm='git commit -S -s -m'
    alias gd='git diff'
    alias gdca='git diff --cached'
    alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
    alias gdcw='git diff --cached --word-diff'
    alias gds='git diff --staged'
    alias gdt='git diff-tree --no-commit-id --name-only -r'
    alias gdup='git diff @{upstream}'
    alias gdw='git diff --word-diff'
    alias gf='git fetch'
    alias gfa='git fetch --all --prune --jobs=10'
    alias gfg='git ls-files | grep'
    alias gfo='git fetch origin'
    alias gg='git gui citool'
    alias gga='git gui citool --amend'
    alias ggpull='git pull origin "$(git_current_branch)"'
    alias ggpur=ggu
    alias ggpush='git push origin "$(git_current_branch)"'
    alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
    alias ghh='git help'
    alias gignore='git update-index --assume-unchanged'
    alias gignored='git ls-files -v | grep "^[[:lower:]]"'
    alias gk='\gitk --all --branches &!'
    alias gke='\gitk --all $(git log -g --pretty=%h) &!'
    alias gl='git pull'
    alias glg='git log --stat'
    alias glgg='git log --graph'
    alias glgga='git log --graph --decorate --all'
    alias glgm='git log --graph --max-count=10'
    alias glgp='git log --stat -p'
    alias glo='git log --oneline --decorate'
    alias globurl='noglob urlglobber '
    alias glod='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'
    alias glods='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'\'' --date=short'
    alias glog='git log --oneline --decorate --graph'
    alias gloga='git log --oneline --decorate --graph --all'
    alias glol='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'
    alias glola='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --all'
    alias glols='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --stat'
    alias gluc='git pull upstream $(git_current_branch)'
    alias glum='git pull upstream $(git_main_branch)'
    alias gm='git merge'
    alias gma='git merge --abort'
    alias gmom='git merge origin/$(git_main_branch)'
    alias gmtl='git mergetool --no-prompt'
    alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
    alias gmum='git merge upstream/$(git_main_branch)'
    alias gp='git push'
    alias gpd='git push --dry-run'
    alias gpf='git push --force-with-lease'
    alias gpoat='git push origin --all && git push origin --tags'
    alias gpr='git pull --rebase'
    alias gpristine='git reset --hard && git clean -dffx'
    alias gpsup='git push --set-upstream origin $(git_current_branch)'
    alias gpu='git push upstream'
    alias gpv='git push -v'
    alias gr='git remote'
    alias gra='git remote add'
    alias grb='git rebase'
    alias grba='git rebase --abort'
    alias grbc='git rebase --continue'
    alias grbd='git rebase $(git_develop_branch)'
    alias grbi='git rebase -i'
    alias grbm='git rebase $(git_main_branch)'
    alias grbo='git rebase --onto'
    alias grbom='git rebase origin/$(git_main_branch)'
    alias grbs='git rebase --skip'
    alias grev='git revert'
    alias grh='git reset'
    alias grhh='git reset --hard'
    alias grm='git rm'
    alias grmc='git rm --cached'
    alias grmv='git remote rename'
    alias groh='git reset origin/$(git_current_branch) --hard'
    alias grrm='git remote remove'
    alias grs='git restore'
    alias grset='git remote set-url'
    alias grss='git restore --source'
    alias grst='git restore --staged'
    alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
    alias gru='git reset --'
    alias grup='git remote update'
    alias grv='git remote -v'
    alias gsb='git status -sb'
    alias gsd='git svn dcommit'
    alias gsh='git show'
    alias gsi='git submodule init'
    alias gsps='git show --pretty=short --show-signature'
    alias gsr='git svn rebase'
    alias gss='git status -s'
    alias gst='git status'
    alias gsta='git stash push'
    alias gstaa='git stash apply'
    alias gstall='git stash --all'
    alias gstc='git stash clear'
    alias gstd='git stash drop'
    alias gstl='git stash list'
    alias gstp='git stash pop'
    alias gsts='git stash show --text'
    alias gstu='gsta --include-untracked'
    alias gsu='git submodule update'
    alias gsw='git switch'
    alias gswc='git switch -c'
    alias gswd='git switch $(git_develop_branch)'
    alias gswm='git switch $(git_main_branch)'
    alias gts='git tag -s'
    alias gtv='git tag | sort -V'
    alias gunignore='git update-index --no-assume-unchanged'
    alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
    alias gup='git pull --rebase'
    alias gupa='git pull --rebase --autostash'
    alias gupav='git pull --rebase --autostash -v'
    alias gupom='git pull --rebase origin $(git_main_branch)'
    alias gupomi='git pull --rebase=interactive origin $(git_main_branch)'
    alias gupv='git pull --rebase -v'
    alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
    alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
fi
