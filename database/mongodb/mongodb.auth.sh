#!/bin/bash

cat <<EOF | mongo
use admin
db.addUser('admin','chen')
db.system.users.find()
exit
EOF

echo "admin password: chen"

sed -i "s/#auth = true/auth = true/" /etc/mongod.conf

systemctl restart  mongod