#!/bin/bash

dnf install openvpn easy-rsa -y
chkconfig openvpn on

cp /usr/share/doc/openvpn-2.4.6/sample/sample-config-files/server.conf /etc/openvpn/
cd /usr/share/easy-rsa/3.0.3/

cat > vars <<EOF
set_var EASYRSA                 "/usr/share/easy-rsa/3.0.3"
set_var EASYRSA_PKI             "/usr/share/easy-rsa/3.0.3/pki"
set_var EASYRSA_DN              "cn_only"
set_var EASYRSA_REQ_COUNTRY     "CN"
set_var EASYRSA_REQ_PROVINCE    "Guangdong"
set_var EASYRSA_REQ_CITY        "Shenzhen"
set_var EASYRSA_REQ_ORG         "Netkiller CERTIFICATE AUTHORITY"
set_var EASYRSA_REQ_EMAIL       "netkiller@msn.com"
set_var EASYRSA_REQ_OU          "Netkiller EASY CA"
set_var EASYRSA_KEY_SIZE        2048
set_var EASYRSA_ALGO            rsa
set_var EASYRSA_CA_EXPIRE       7500
set_var EASYRSA_CERT_EXPIRE     365
set_var EASYRSA_NS_SUPPORT      "no"
set_var EASYRSA_NS_COMMENT      "Netkiller CERTIFICATE AUTHORITY"
set_var EASYRSA_EXT_DIR         "/usr/share/easy-rsa/3.0.3/x509-types"
set_var EASYRSA_SSL_CONF        "/usr/share/easy-rsa/3.0.3/openssl-1.0.cnf"
set_var EASYRSA_DIGEST          "sha256"
EOF

easyrsa init-pki
easyrsa build-ca nopass
easyrsa gen-dh
easyrsa gen-req server nopass
easyrsa sign-req server server nopass
easyrsa build-client-full client nopass

cp pki/ca.crt pki/dh.pem pki/private/server.key pki/issued/server.crt /etc/openvpn/

vim /etc/openvpn/server.conf <<end > /dev/null 2>&1
:85,85s/dh2048.pem/dh.pem/
:wq
end


systemctl enable openvpn@server.service
systemctl start openvpn@server.service

iptables -A INPUT -p udp --dport 1194 -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
