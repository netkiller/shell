#!/bin/sh
###########################################
# http://netkiller.github.io
# Neo chen <netkiller@msn.com>
###########################################
ARCH=$(uname -i)
SYSTEM=$(awk -F' ' 'NR==1 {print $(1)}' /etc/issue)
VERSION=$(awk -F' ' 'NR==1 {print $(3)}' /etc/issue)
###########################################
if [ ${SYSTEM} = 'CentOS' ]; then
	yum install -y zsh
fi

if [ ${SYSTEM} = 'Ubuntu' ]; then
	sudo apt-get install zsh -y
fi

chsh -s /bin/zsh

cat >> ~/.zshrc <<EOF

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

EOF

cat >> ~/.zsh_aliases <<'EOF'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

EOF
