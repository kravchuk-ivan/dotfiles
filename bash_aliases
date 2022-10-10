#!/bin/bash

###
# Put the following script into '.bashrc' or alike
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


# General aliases
alias j-='j -'
alias j\/='j /'
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
        alias cpwd='pwd | clip.exe && echo "COPIED " ; echo $PWD ; echo " to Windows system clipboard!" || echo \"ERROR: Could not copy the absolute path!\"' ;
        alias jwr="j /mnt/c/" ;
        alias jwh="j /mnt/c/Users/ivan.kravchuk/" ;
        alias jdl="cd /mnt/c/Users/ivan.kravchuk/Downloads && ls -Alhtr" ;
        alias jdt="j /mnt/c/Users/ivan.kravchuk/Desktop" ;
        alias jod="j /mnt/c/Users/ivan.kravchuk/Desktop/OneDrive\ -\ SNT\ Group" ;

        # Kontron-specific aliases
        alias jwg="j /mnt/c/git/cnms-3.1/" ;
    ;;
    darwin*)
        alias brew-update="brew update && brew upgrade" ;
        alias jdl="cd $HOME/Downloads && ls -Alhtr" ;
        alias jdt="j $HOME/Desktop" ;
        alias jod="j $HOME/Desktop/OneDrive\ -\ SNT\ Group"
        alias cpwd='pwd | pbcopy && echo "COPIED " ; echo $PWD ; echo " to macOS clipboard!" || echo \"ERROR: Could not copy the absolute path!\"' ;
    ;;
    msys*)
        alias jwr="j /c/" ;
        alias jdl="cd /c/Users/ivan.kravchuk/Downloads && ls -Alhtr" ;
        alias jdt="j /c/Users/ivan.kravchuk/Desktop" ;

        # Kontron-specific aliases
        alias jwg="j /c/git/cnms-3.1/" ;
    ;;
    bsd*)
    ;;
    cygwin*)
    ;;
    *)
        echo "WARNING: there are no configurations specified for $OSTYPE"
    ;;
esac
