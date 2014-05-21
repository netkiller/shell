yum install -y postfix
chkconfig postfix on
service postfix start

cp /etc/postfix/main.cf{,.original}
cp /etc/postfix/master.cf{,.original}

sed -i '77imyhostname = mail.example.com' main.cf
sed -i '85imydomain = example.com' main.cf
sed -i '102imyorigin = $mydomain' main.cf
# inet_interfaces
sed -i '116s/#//' main.cf
sed -i '119s/^/#/' main.cf
# mydestination
sed -i '167s/^/#/' main.cf
sed -i '168s/#//' main.cf
# home_mailbox
sed -i '422s/#//' main.cf

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 25 -j ACCEPT
service iptables save