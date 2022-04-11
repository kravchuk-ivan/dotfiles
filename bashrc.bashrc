# .bashrc

# Function to enhance cd with ls -Altr aliased as j
j() {
    cd "$@" && ls -Altr;
}
jj() {
    cd .. && ls -Altr; 
}
jjj() {
    cd ../.. && ls -Altr; 
}
jj3() {
    cd ../../.. && ls -Altr; 
}
jj4() {
    cd ../../../.. && ls -Altr; 
}
jj5() {
    cd ../../../../.. && ls -Altr; 
}

# User specific aliases and functions
alias k='vim' # or nvim
alias l='ls -la'
alias ~='cd ~'
alias s='fzf'
