#!/bin/sh

cat << 'EOF' >> /etc/yum.repos.d/mongodb-org-5.0.repo
[mongodb-org-5.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/5.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-5.0.asc
EOF

dnf install -y mongodb-org-server
dnf install -y mongodb-org-shell
dnf install -y mongodb-org-tools

cp /etc/mongod.conf{,.original}


cat << 'EOF' >>  /etc/security/limits.d/20-nofile.conf 
mongod soft nofile 65000
mongod hard nofile 65000
EOF

systemctl is-enabled mongod
systemctl start mongod