#!/bin/sh

cat << 'EOF' >> /etc/dnf.repos.d/mongodb-org-4.0.repo
[mongodb-org-4.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/dnf/redhat/$releasever/mongodb-org/4.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc
EOF

dnf install -y mongodb-org-server
dnf install -y mongodb-org-shell

cp /etc/mongod.conf{,.original}

systemctl is-enabled mongod
systemctl start mongod