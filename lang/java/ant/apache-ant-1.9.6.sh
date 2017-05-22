#!/bin/bash

cd /usr/local/src/
wget http://ftp.cuhk.edu.hk/pub/packages/apache.org//ant/binaries/apache-ant-1.9.6-bin.tar.bz2
tar jxf apache-ant-1.9.6-bin.tar.bz2
mv apache-ant-1.9.6 /srv
ln -s /srv/apache-ant-1.9.6 /srv/apache-ant

cat >> /etc/profile.d/apache-ant.sh <<'EOF'
export PATH=/srv/apache-ant/bin:$PATH
EOF

source /etc/profile.d/apache-ant.sh