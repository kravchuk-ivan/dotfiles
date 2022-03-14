# .bashrc

# Resemble functionality of zsh and oh-my-zsh for bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias jk='vim'
alias kj='vim'
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias cd1="cd .."
alias cd2="cd ../.."
alias cd3="cd ../../.."
alias cd4="cd ../../../.."
alias cd5="cd ../../../../.."

alias l='ls -la'

alias logs='cd /opt/opennms/logs'
alias share='cd /opt/opennms/share'

alias loglevel='vi /opt/opennms/etc/log4j2.xml'

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi
