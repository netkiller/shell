#!/bin/bash

cd /usr/local/src/
wget http://apache.01link.hk//ant/binaries/apache-ant-1.10.1-bin.tar.bz2
tar jxvf apache-ant-1.10.1-bin.tar.bz2
mv apache-ant-1.10.1 /srv
rm -f /srv/apache-ant
ln -s /srv/apache-ant-1.10.1 /srv/apache-ant

cat >> /etc/profile.d/apache-ant.sh <<'EOF'
export PATH=/srv/apache-ant/bin:$PATH
EOF

source /etc/profile.d/apache-ant.sh