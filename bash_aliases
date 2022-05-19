# .bashrc

# # The following conditional script should be included into bashrc or zshrc or alike file to source the aliases that this file contains.

# if [ -f ~/softergonomics/bash_aliases ]
# then
#     source ~/softergonomics/bash_aliases
# else
#     echo "'~/softergonomics/bash_aliases' was not found. The aliases could not be updated."
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

# User specific aliases and functions
alias k='nvim'
alias l='ls -Althr'
alias s='fzf'
alias d='vifm . .'

# Linux Ubuntu specific aliases
alias apt-update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade'

# WSL2 Ubuntu specific aliases
alias cpwd="pwd | clip.exe"
