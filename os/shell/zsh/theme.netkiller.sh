#!/bin/sh
###########################################
# http://netkiller.github.io
# Neo chen <netkiller@msn.com>
###########################################
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="netkiller"/' ~/.zshrc
###########################################
wget -q https://raw.githubusercontent.com/netkiller/shell/master/os/shell/zsh/theme/netkiller.zsh-theme -O ~/.oh-my-zsh/themes

