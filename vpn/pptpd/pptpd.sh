#!/bin/bash

yum install -y pptpd ppp
systemctl enable pptpd

cp /etc/pptpd.conf{,.original}
cat >> /etc/pptpd.conf <<EOF
localip 192.168.4.1
remoteip 192.168.4.5-30
EOF


cp /etc/ppp/options.pptpd{,.original}
cat >> /etc/ppp/options.pptpd <<EOF
ms-dns 208.67.222.222
ms-dns 208.67.220.220
EOF

cp /etc/ppp/chap-secrets{,.original}
cat >> /etc/ppp/chap-secrets <<-EOF
neo pptpd chen *
EOF


cat > /etc/sysctl.d/pptpd.conf <<-EOF
net.ipv4.ip_forward = 1
EOF
sysctl -p /etc/sysctl.d/pptpd.conf 
#echo 1 > /proc/sys/net/ipv4/ip_forward


iptables -A INPUT -p tcp --dport 1723 -j ACCEPT
iptables -A INPUT -p tcp --dport 47 -j ACCEPT
iptables -A INPUT -p gre -j ACCEPT
iptables -A INPUT -p UDP --dport 53 -j ACCEPT

iptables -t nat -A POSTROUTING -s 192.168.4.0/24 -o eth1 -j MASQUERADE

#iptables -t nat -A POSTROUTING -s 192.168.4.0/24 -o br0 -j MASQUERADE
