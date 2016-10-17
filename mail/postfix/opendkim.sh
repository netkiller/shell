#!/bin/sh

yum install -y opendkim

cp /etc/opendkim.conf{,.original}
cp /etc/opendkim/KeyTable{,.original}
cp /etc/opendkim/SigningTable{,.original}
cp /etc/opendkim/TrustedHosts{,.original}

systemctl enable opendkim

#cp /etc/opendkim.conf{,.original}

mkdir /etc/opendkim/keys/example.com
opendkim-genkey -D /etc/opendkim/keys/example.com/ -d example.com -s default
#/etc/opendkim/keys/example.com/default.private

cat /etc/opendkim/KeyTable

cat >> /etc/opendkim/SigningTable <<EOF
*@example.com default._domainkey.example.com
EOF

systemctl start opendkim

cat >> /etc/postfix/main.cf <<EOF

smtpd_milters           = inet:127.0.0.1:8891
non_smtpd_milters       = inet:127.0.0.1:8891
milter_protocol         = 2
milter_default_action   = accept
EOF

systemctl restart postfix 