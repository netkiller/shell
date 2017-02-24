#!/bin/bash

# Install Strongswan

yum install -y strongswan

cp /etc/strongswan/ipsec.conf{,.original}

# Certificates

yum install -y haveged
systemctl enable haveged
systemctl start haveged

cd /etc/strongswan
strongswan pki --gen --type rsa --size 4096 --outform der > ipsec.d/private/strongswanKey.der
chmod 600 ipsec.d/private/strongswanKey.der
strongswan pki --self --ca --lifetime 3650 --in ipsec.d/private/strongswanKey.der --type rsa --dn "C=NL, O=Example Company, CN=strongSwan Root CA" --outform der > ipsec.d/cacerts/strongswanCert.der
strongswan  pki --print --in ipsec.d/cacerts/strongswanCert.der

strongswan pki --gen --type rsa --size 2048 --outform der > ipsec.d/private/vpnHostKey.der
chmod 600 ipsec.d/private/vpnHostKey.der
strongswan pki --pub --in ipsec.d/private/vpnHostKey.der --type rsa | strongswan pki --issue --lifetime 730 --cacert ipsec.d/cacerts/strongswanCert.der --cakey ipsec.d/private/strongswanKey.der --dn "C=NL, O=Example Company, CN=vpn.example.org" --san vpn.example.com --san vpn.example.net --san 47.90.44.87  --san @47.90.44.87 --flag serverAuth --flag ikeIntermediate --outform der > ipsec.d/certs/vpnHostCert.der
strongswan pki --print --in ipsec.d/certs/vpnHostCert.der

# openssl x509 -inform DER -in ipsec.d/certs/vpnHostCert.der -noout -text

# Client certificate
cd /etc/strongswan/
strongswan pki --gen --type rsa --size 2048 --outform der > ipsec.d/private/JohnKey.der
chmod 600 ipsec.d/private/JohnKey.der

strongswan pki --pub --in ipsec.d/private/JohnKey.der --type rsa | strongswan pki --issue --lifetime 730 --cacert ipsec.d/cacerts/strongswanCert.der --cakey ipsec.d/private/strongswanKey.der --dn "C=NL, O=Example Company, CN=john@example.org" --san "john@example.org" --san "john@example.net" --outform der > ipsec.d/certs/JohnCert.der

openssl rsa -inform DER -in ipsec.d/private/JohnKey.der -out ipsec.d/private/JohnKey.pem -outform PEM
openssl x509 -inform DER -in ipsec.d/certs/JohnCert.der -out ipsec.d/certs/JohnCert.pem -outform PEM
openssl x509 -inform DER -in ipsec.d/cacerts/strongswanCert.der -out ipsec.d/cacerts/strongswanCert.pem -outform PEM

openssl pkcs12 -export  -inkey ipsec.d/private/JohnKey.pem -in ipsec.d/certs/JohnCert.pem -name "John's VPN Certificate"  -certfile ipsec.d/cacerts/strongswanCert.pem -caname "strongSwan Root CA" -out John.p12

# IPSEC Configuration

cat > /etc/strongswan/ipsec.conf <<EOF
# ipsec.conf - strongSwan IPsec configuration file

config setup
    charondebug="ike 2, knl 2, cfg 2, net 2, esp 2, dmn 2,  mgr 2"

conn %default
    keyexchange=ikev2
    ike=aes128-sha256-ecp256,aes256-sha384-ecp384,aes128-sha256-modp2048,aes128-sha1-modp2048,aes256-sha384-modp4096,aes256-sha256-modp4096,aes256-sha1-modp4096,aes128-sha256-modp1536,aes128-sha1-modp1536,aes256-sha384-modp2048,aes256-sha256-modp2048,aes256-sha1-modp2048,aes128-sha256-modp1024,aes128-sha1-modp1024,aes256-sha384-modp1536,aes256-sha256-modp1536,aes256-sha1-modp1536,aes256-sha384-modp1024,aes256-sha256-modp1024,aes256-sha1-modp1024!
    esp=aes128gcm16-ecp256,aes256gcm16-ecp384,aes128-sha256-ecp256,aes256-sha384-ecp384,aes128-sha256-modp2048,aes128-sha1-modp2048,aes256-sha384-modp4096,aes256-sha256-modp4096,aes256-sha1-modp4096,aes128-sha256-modp1536,aes128-sha1-modp1536,aes256-sha384-modp2048,aes256-sha256-modp2048,aes256-sha1-modp2048,aes128-sha256-modp1024,aes128-sha1-modp1024,aes256-sha384-modp1536,aes256-sha256-modp1536,aes256-sha1-modp1536,aes256-sha384-modp1024,aes256-sha256-modp1024,aes256-sha1-modp1024,aes128gcm16,aes256gcm16,aes128-sha256,aes128-sha1,aes256-sha384,aes256-sha256,aes256-sha1!
    dpdaction=clear
    dpddelay=300s
    rekey=no
    left=%any
    leftsubnet=0.0.0.0/0
    leftcert=vpnHostCert.der
    right=%any
    rightdns=8.8.8.8,8.8.4.4
    rightsourceip=10.42.42.0/24

conn IPSec-IKEv2
    keyexchange=ikev2
    auto=add

conn IPSec-IKEv2-EAP
    also="IPSec-IKEv2"
    rightauth=eap-mschapv2
    rightauthby2=pubkey
    rightsendcert=never
    eap_identity=%any

conn CiscoIPSec
    keyexchange=ikev1
    forceencaps=yes
    authby=xauthrsasig
    xauth=server
    auto=add
EOF

# VPN user accounts and secrets
cat > /etc/strongswan/ipsec.secrets <<EOF
: RSA vpnHostKey.der

alice : EAP "YzCgnveYuL429fH" 
bob : EAP "E23pOjvW8z248iAp" 
hipster: XAUTH "xauth_ikev1_example_password"
EOF

cat > /etc/sysctl.d/vpn.conf <<EOF
# VPN
net.ipv4.ip_forward = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
EOF

sysctl -p /etc/sysctl.d/vpn.conf

systemctl enable strongswan
systemctl start strongswan

# for ISAKMP (handling of security associations)
iptables -A INPUT -p udp --dport 500 --j ACCEPT
# for NAT-T (handling of IPsec between natted devices)
iptables -A INPUT -p udp --dport 4500 --j ACCEPT
# for ESP payload (the encrypted data packets)
iptables -A INPUT -p esp -j ACCEPT
iptables -A INPUT -p ah -j ACCEPT
# for the routing of packets on the server
iptables -I POSTROUTING -t nat -o eth1 -j MASQUERADE
# iptables -t nat -A POSTROUTING -o eth+ -j SNAT --to-source %SERVERIP%
# iptables -t nat -A POSTROUTING -o eth0 ! -p esp -j SNAT --to-source "your VPN host IP"

#systemctl reload iptables