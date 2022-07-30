#!/bin/bash

# # The following conditional script should be included into .bashrc or .zshrc or similar file to source the aliases that this file contains.
# Use $HOME instead of ~ (cross-platform)

# if [[ -f $HOME/sf/bash_aliases ]]
# then
#     source $HOME/sf/bash_aliases
# else
#     echo "[ERROR]:'$HOME/sf/bash_aliases' was not found."
# fi

# Functions to enhance `cd` with `ls -Altr` aliased as `j`
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
jj3() {
    cd ../../.. && ls -Alh; 
}
jjjjj() {
    cd ../../../.. && ls -Alh; 
}
jj4() {
    cd ../../../.. && ls -Alh; 
}
jjjjjj() {
    cd ../../../../.. && ls -Alh; 
}
jj5() {
    cd ../../../../.. && ls -Alh; 
}

# OS-agnostic aliases
alias k='nvim'
alias l='ls -Alh'
alias s='fzf'
alias d='vifm . .'
alias jb='j -'

# OS-specific aliases
case "$OSTYPE" in
    linux-gnu*)
        alias apt-update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade' ;
        # The problem with echoing the path is that it invokes a new subshell every time you call the command and therefore you always have the home path
        alias cpwd="pwd | clip.exe && echo \"COPIED '$(pwd)' to Windows system clipboard!\" || echo \"ERROR: Could not copy the absolute path!\"" ;
        alias jsd="j $HOME/sd" ;
        alias jsf="j $HOME/sf" ;
        alias jwh="j /mnt/c/Users/ivan.kravchuk/" ;
        alias jwr="j /mnt/c/" ;

        alias jwg="j /mnt/c/git/cnms-3.1/" ;
    ;;
    darwin*) 
        alias jsd="j $HOME/sd" ;
        alias jsf="j $HOME/sf" ;
    ;;
    msys*) 
        alias jsd="j $HOME/sd" ;
        alias jsf="j $HOME/sf" ;
        alias jwh="j /c/Users/ivan.kravchuk/" ;
        alias jwr="j /c/" ;

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
