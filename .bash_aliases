# .bashrc

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
alias k='vim' # or `nvim`
alias l='ls -Althr'
alias ~='cd ~'
alias s='fzf'
alias apt-update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade'


# Microsoft OS specific aliases for WSL
alias cpwd="pwd | clip.exe"
