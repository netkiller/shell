domain=netkiller.cn
cmd=/tmp/spf.sh
if [ -f $cmd ]; then
	bash $cmd $domain
else
	curl -s https://raw.githubusercontent.com/oscm/shell/master/mail/spf.sh > $cmd
fi


domain=netkiller.cn; cmd=/tmp/spf.sh; if [ -f $cmd ]; then bash $cmd $domain; else curl -s https://raw.githubusercontent.com/oscm/shell/master/mail/spf.sh > $cmd; fi
