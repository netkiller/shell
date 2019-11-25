#!/bin/bash

dnf install -y pptp pptp-setup
systemctl enable pptpd

cp /etc/ppp/options.pptp{,.original}
cp /etc/ppp/ip-up{,.original}

cat >> /etc/ppp/ip-up.local <<EOF
ip route add 172.16.0.0/24 dev ppp0  scope link
EOF

cat >> /etc/ppp/ip-down.local <<EOF
ip route del 172.16.0.0/24 dev ppp0
EOF

chmod +x /etc/ppp/ip-up.local /etc/ppp/ip-down.local

pptpsetup --create vpn0 --server vpn.netkiller.cn \
--username neo --password netkiller --encrypt

