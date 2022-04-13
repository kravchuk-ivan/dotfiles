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
jj3() {
    cd ../../.. && ls -Althr; 
}
jj4() {
    cd ../../../.. && ls -Althr; 
}
jj5() {
    cd ../../../../.. && ls -Althr; 
}

# User specific aliases and functions
alias k='vim' # or `nvim`
alias l='ls -Althr'
alias ~='cd ~'
alias s='fzf'

# Microsoft OS specific aliases for WSL
alias cpwd="pwd | clip.exe"
