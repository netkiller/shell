
yum install -y postfix
systemctl enable postfix

cp /etc/postfix/main.cf{,.original}
cp /etc/postfix/master.cf{,.original}

cat > /etc/security/limits.d/95-postfix.conf <<EOF
postfix    soft    nproc    4096
postfix    soft    nofile   40960
EOF

sed -i '77imyhostname = mail.example.com' /etc/postfix/main.cf
sed -i '85imydomain = example.com' /etc/postfix/main.cf
sed -i '102imyorigin = $mydomain' /etc/postfix/main.cf
# inet_interfaces
sed -i '116s/#//' /etc/postfix/main.cf
sed -i '119s/^/#/' /etc/postfix/main.cf
# mydestination
sed -i '167s/^/#/' /etc/postfix/main.cf
sed -i '168s/#//' /etc/postfix/main.cf
# home_mailbox
sed -i '422s/#//' /etc/postfix/main.cf
# trust mynetworks
#sed -i '269imynetworks = xxx.xxx.xxx.xxx' /etc/postfix/main.cf

systemctl restart postfix

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 25 -j ACCEPT
service iptables save


