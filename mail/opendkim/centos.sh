#!/bin/sh
yum install -y opendkim
systemctl enable opendkim


cp /etc/opendkim.conf{,.original}

mkdir /etc/opendkim/keys/YourDomain.com
opendkim-genkey -D /etc/opendkim/keys/YourDomain.com/ -d YourDomain.com -s default

cat /etc/opendkim/KeyTable

cat >> /etc/opendkim/SigningTable <<EOF
*@YourDomain.com default._domainkey.YourDomain.com
EOF



#/etc/opendkim/keys/YourDomain.com/default.txt

systemctl start opendkim 

cat >> /etc/postfix/main.cf

smtpd_milters           = inet:127.0.0.1:8891
non_smtpd_milters       = inet:127.0.0.1:8891
milter_protocol         = 2
milter_default_action   = accept
EOF

systemctl restart postfix 