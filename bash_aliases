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

# General aliases
alias k='nvim'
alias l='ls -Alh'
alias s='fzf'
alias d='vifm . .'
alias jb='j -'
alias jsd="j $HOME/sd" ;
alias jsf="j $HOME/sf" ;
alias jt="j $HOME/tmp" ;
alias jd="j $HOME/Desktop" ;

# OS-specific aliases
case "$OSTYPE" in
    linux-gnu*)
        alias apt-update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade' ;
        # The problem with echoing the path is that it invokes a new subshell every time you call the command and therefore you always have the home path
        alias cpwd="pwd | clip.exe && echo \"COPIED '$(pwd)' to Windows system clipboard!\" || echo \"ERROR: Could not copy the absolute path!\"" ;
        alias jwr="j /mnt/c/" ;
        alias jwh="j /mnt/c/Users/ivan.kravchuk/" ;

        # Kontron-specific aliases
        alias jwg="j /mnt/c/git/cnms-3.1/" ;
    ;;
    darwin*)
        alias brew-update="brew update && brew upgrade" ;
    ;;
    msys*)
        alias jwr="j /c/" ;
        alias jwh="j /c/Users/ivan.kravchuk/" ;
        
        # Kontron-specific aliases
        alias jwg="j /c/git/cnms-3.1/" ;
    ;;
    bsd*)
    ;;
    cygwin*)
    ;;
    *)
        echo "WARNING: there are no configurations specified for $(echo $OSTYPE)!"
    ;;
esac
