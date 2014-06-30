yum install -y freeradius freeradius-utils

chkconfig radiusd on
service radiusd start

cp /etc/raddb/clients.conf{,.original}
cp /etc/raddb/users{,.original}
cp /etc/raddb/sites-enabled/default{,.original}

cat >> /etc/raddb/clients.conf <<EOF

client 192.168.0.0/16 {
       secret          = testing123
       shortname       = freeradius.example.com
}
EOF

echo "guest Cleartext-Password := "test"" >> /etc/raddb/users