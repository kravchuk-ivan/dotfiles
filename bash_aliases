# .bashrc

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

# OS-agnostic aliases and functions
alias k='nvim'
alias l='ls -Althr'
alias s='fzf'
alias d='vifm . .'

# OS-specific aliases (commented out and are directly inserted into the respective .bashrc)

## WSL2 Ubuntu specific aliases
# alias apt-update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade'
# alias cpwd="pwd | clip.exe"
# alias winhome="j /mnt/c/Users/ivan.kravchuk/"
# alias winroot="j /mnt/c/"
# alias wingit="j /mnt/c/git/cnms-3.1/"
# alias jsf="j $HOME/sf"
# alias jsd="j $HOME/sd"
