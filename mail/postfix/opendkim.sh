#!/bin/sh

yum install -y opendkim

cp /etc/opendkim.conf{,.original}
cp /etc/opendkim/KeyTable{,.original}
cp /etc/opendkim/SigningTable{,.original}
cp /etc/opendkim/TrustedHosts{,.original}

#sed -i "39s/v/sv/" /etc/opendkim.conf
sed -i "39s/Mode\t v/Mode\tsv/" /etc/opendkim.conf
sed -i '103s/# KeyTable/KeyTable/' /etc/opendkim.conf
sed -i '108s/# SigningTable/SigningTable/' /etc/opendkim.conf
sed -i '115s/# InternalHosts/InternalHosts/' /etc/opendkim.conf

systemctl enable opendkim

#cp /etc/opendkim.conf{,.original}

mkdir /etc/opendkim/keys/example.com
opendkim-genkey -D /etc/opendkim/keys/example.com/ -d example.com -s default
#/etc/opendkim/keys/example.com/default.private

cat /etc/opendkim/KeyTable

cat >> /etc/opendkim/SigningTable <<EOF
*@example.com default._domainkey.example.com
EOF

cat >> TrustedHosts <<EOF
# your all of server ip address.
EOF

systemctl start opendkim

cat >> /etc/postfix/main.cf <<'EOF'

smtpd_milters           = inet:127.0.0.1:8891
non_smtpd_milters       = $smtpd_milters
milter_protocol         = 2
milter_default_action   = accept
EOF

systemctl restart postfix 