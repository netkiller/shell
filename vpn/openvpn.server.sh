#!/bin/bash

yum install openvpn easy-rsa -y
chkconfig openvpn on

cp /usr/share/doc/openvpn-2.3.6/sample/sample-config-files/server.conf /etc/openvpn/
cd /usr/share/easy-rsa/2.0

cat >> vars <<EOF
# Add by BG7NYT
export KEY_COUNTRY="CN"
export KEY_PROVINCE="GD"
export KEY_CITY="Shenzhen"
export KEY_ORG="Personal Amateur Radiostations of P.R.China"
export KEY_EMAIL="bg7nyt@163.com"
export KEY_CN=http://netkiller.github.io
export KEY_NAME=BG7NYT
export KEY_OU=Mototrbo
EOF

#export PKCS11_MODULE_PATH=changeme
#export PKCS11_PIN=1234

source ./vars
./clean-all
./build-ca
./build-key-server server
./build-dh
./build-key node1

cp keys/ca.key keys/ca.crt keys/dh2048.pem keys/server.key keys/server.crt /etc/openvpn/

service openvpn start

iptables -A INPUT -p udp --dport 1194 -j ACCEPT
iptables -t nat -A POSTROUTING -s 192.168.6.0/24 -o eth1 -j MASQUERADE
