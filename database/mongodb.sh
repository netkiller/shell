#!/bin/bash
sudo apt-get install mongodb

chkconfig mongodb on
service mongodb start

cat <<EOF | mongo
use admin
db.addUser('admin','chen')
db.system.users.find()
exit
EOF

echo "admin password: chen"

sudo cp /etc/mongodb.conf{,.original}
sudo sed -i "s/#auth = true/auth = true/" /etc/mongodb.conf

sudo /etc/init.d/mongodb restart

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 27017 -j ACCEPT
service iptables save
