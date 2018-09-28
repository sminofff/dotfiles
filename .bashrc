# .bashrc

# User specific aliases and functions

export EDITOR=vim
eval "$(direnv hook bash)"
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
