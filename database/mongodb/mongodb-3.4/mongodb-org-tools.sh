#!/bin/sh

cat << 'EOF' >> /etc/yum.repos.d/mongodb-org-3.4.repo
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
EOF

yum install -y mongodb-org-server

cp /etc/mongod.conf{,.original}

systemctl is-enabled mongod
systemctl start mongod

yum install -y mongodb-org-shell

