dnf install gearmand -y
chkconfig gearmand on
service gearmand start

cat >> /etc/sysconfig/gearmand <<EOF

OPTIONS="--log-file=/var/log/gearman.log --threads=512"
EOF

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 4730 -j ACCEPT
service iptables save