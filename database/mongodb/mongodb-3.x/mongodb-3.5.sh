#!/bin/sh

cat << 'EOF' >> /etc/dnf.repos.d/mongodb-org-3.6.repo
[mongodb-org-3.6]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/dnf/redhat/$releasever/mongodb-org/3.6/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc
EOF

dnf install -y mongodb-org-server
dnf install -y mongodb-org-shell

cp /etc/mongod.conf{,.original}

systemctl is-enabled mongod
systemctl start mongod

