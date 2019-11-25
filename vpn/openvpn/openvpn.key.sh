#!/bin/bash

dnf install -y easy-rsa

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
