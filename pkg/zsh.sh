pkg_add -r zsh
chsh -s zsh
# usermod -s /usr/local/bin/zsh neo
# chpass -s /usr/local/bin/zsh

cat >> ~/.login_conf <<'EOF'

me:\
	:charset=UTF-8:\
	:lang=en_US.UTF-8:
EOF

cat > ~/.zshrc <<'EOD'
# Created by neo <netkiller@msn.com>
zstyle ':completion:*' menu select
setopt completealiases

# enable color support of ls and also add handy aliases
# autoload colors; colors
autoload -U colors compinit promptinit
colors
compinit
promptinit

PROMPT='%n@%M:%~%# '
#PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%1~ %{$reset_color%}%#"
RPROMPT="[%{$fg[yellow]%}%?%{$reset_color%}]"
PS1="%B[%{$fg[red]%}%n%{$reset_color%}%b@%B%{$fg[cyan]%}%m%b%{$reset_color%}:%~%B]%b%# "

if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    
	# some more ls aliases
	alias ll='ls -l'
	alias la='ls -A'
	alias l='ls -CF'    
fi

# global aliases
alias -g '...'='../..'
alias -g '....'='../../..'

if [[ $OSTYPE = freebsd* ]]; then 
    export CLICOLOR="YES"
    export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"
    export GREP_OPTIONS="--color=auto"
    alias ls="ls -GF"
    alias ll="ls -lhGF"
    alias la="ls -lhaGF"
    
    alias halt="halt -p"
fi

# exporting colors
export GREP_COLOR=31

# even more colour-candy with app-misc/grc (http://goo.gl/2z2j)
if [ "$TERM" != dumb ] && [ -x /usr/bin/grc ] ; then
   alias cl='/usr/bin/grc -es --colour=auto'
   alias configure='cl ./configure'
   alias diff='cl diff'
   alias gcc='cl gcc'
   alias g++='cl g++'
   alias as='cl as'
   alias gas='cl gas'
   alias ld='cl ld'
   alias netstat='cl netstat'
   alias ping='cl ping'
fi

# Home/End/Del key
bindkey "\e[1~" beginning-of-line
bindkey "\e[2~" overwrite-mode
bindkey "\e[3~" delete-char
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line

HISTFILE=~/.history
HISTSIZE=1000
SAVEHIST=1000

if [ -r ${HOME}/.profile ]; then
	. ${HOME}/.profile
fi
if [ -r ${HOME}/.login ]; then
	tcsh ${HOME}/.login
fi

EOD
