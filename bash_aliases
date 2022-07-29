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
    cd "$@" && ls -Althr;
}
jj() {
    cd .. && ls -Althr; 
}
jjj() {
    cd ../.. && ls -Althr; 
}
jjjj() {
    cd ../../.. && ls -Althr; 
}
jj3() {
    cd ../../.. && ls -Althr; 
}
jjjjj() {
    cd ../../../.. && ls -Althr; 
}
jj4() {
    cd ../../../.. && ls -Althr; 
}
jjjjjj() {
    cd ../../../../.. && ls -Althr; 
}
jj5() {
    cd ../../../../.. && ls -Althr; 
}

# OS-agnostic aliases
alias k='nvim'
alias l='ls -Althr'
alias s='fzf'
alias d='vifm . .'
alias j-='j -'

# OS-specific aliases

case "$OSTYPE" in
    linux-gnu*)
        alias apt-update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade' ;
        # The problem with echoing the path is that it invokes a new subshell every time you call the command and therefore you always have the home path
        alias cpwd="pwd | clip.exe && echo \"COPIED '$(pwd)' to Windows system clipboard!\" || echo \"ERROR: Could not copy the absolute path!\"" ;
        alias whp="/mnt/c/Users/ivan.kravchuk" ;
        alias jwh="j /mnt/c/Users/ivan.kravchuk/" ;
        alias jwr="j /mnt/c/" ;
        alias jwg="j /mnt/c/git/cnms-3.1/" ;
        alias jsd="j $HOME/sd" ;
        alias jsf="j $HOME/sf" ;
        echo "SUCCESS: updated configurations for $(echo $OSTYPE)!"
    ;;
    darwin*) 
        alias jsd="j $HOME/sd" ;
        alias jsf="j $HOME/sf" ;
        echo "SUCCESS: updated configurations for $(echo $OSTYPE)!"
    ;;
    msys*) 
        alias wingit="j /c/git/cnms-3.1/" ;
        alias winhome="j /c/Users/ivan.kravchuk/" ;
        alias winroot="j /c/" ;
        alias whp="/c/Users/ivan.kravchuk" ;
        alias jwh="j /c/Users/ivan.kravchuk/" ;
        alias jwr="j /c/" ;
        alias jwg="j /c/git/cnms-3.1/" ;
        alias jsd="j $HOME/sd" ;
        alias jsf="j $HOME/sf" ;
        echo "SUCCESS: updated configurations for $(echo $OSTYPE)!"
    ;;
    bsd*)
        echo "SUCCESS: updated configurations for $(echo $OSTYPE)!"
    ;;
    cygwin*)
        echo "SUCCESS: updated configurations for $(echo $OSTYPE)!"
    ;;
    *)
        echo "WARNING: there are no configurations specified for $(echo $OSTYPE)!"
    ;;
esac
