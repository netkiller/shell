yum install -y exim
chkconfig exim on

cp /etc/exim/exim.conf{,.original}

cat > /etc/security/limits.d/95-exim.conf <<EOF
exim    soft    nproc    1024
exim    soft    nofile   40960
EOF

alternatives --config mta

service exim start

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 25 -j ACCEPT
service iptables save


