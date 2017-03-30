#!/bin/sh
###########################################
# http://netkiller.github.io
# Neo chen <netkiller@msn.com>
###########################################
if [ $(id -u) = "0" ]; then
	yum install -y zsh
fi
###########################################
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc

cat >> ~/.zshrc <<EOF

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

EOF

chsh -s /bin/zsh
