#!/bin/bash
if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
        echo 'Only for Redhat or CentOS'
        exit
fi

yum install mongodb-server mongodb -y

chkconfig mongod on
service mongod start

#yum install mongodb

cat <<EOF | mongo
use admin
db.addUser('admin','chen')
db.system.users.find()
exit
EOF

echo "admin password: chen"

cp /etc/mongodb.conf{,.original}
sed -i "s/#auth = true/auth = true/" /etc/mongodb.conf

service mongod reload

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 27017 -j ACCEPT
service iptables save
