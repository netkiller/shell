#!/bin/sh
yum install -y exim
systemctl enable exim


cp /etc/exim/exim.conf{,.original}

cat > /etc/security/limits.d/95-exim.conf <<EOF
exim    soft    nproc    1024
exim    soft    nofile   40960
EOF

# alternatives --config mta
alternatives --set mta /usr/sbin/sendmail.exim

systemctl start exim

iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 25 -j ACCEPT
service iptables save


