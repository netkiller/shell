#!/bin/bash

rpm -ivh http://dnf.opensips.org/1.10/releases/el/6/x86_64/opensips-dnf-releases-1.10-1.el6.noarch.rpm
dnf install opensips opensips-mysql -y


cp /etc/opensips/opensipsctlrc{,.original}
cp /etc/opensips/opensips.cfg{,.original}

cat > /etc/opensips/opensipsctlrc <<EOF
SIP_DOMAIN=opensips.org
DBENGINE=MYSQL
DBHOST=localhost
DBNAME=opensips
DBRWUSER=opensips
DBRWPW="opensips"
USERCOL="username"
ETCDIR="/etc/opensips"
EOF


opensipsdbctl create

chkconfig opensips on
service opensips start

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5060 -j ACCEPT
iptables -A INPUT -p udp --dport 5060 -j ACCEPT