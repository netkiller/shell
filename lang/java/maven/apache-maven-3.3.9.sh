#!/bin/bash

cd /usr/local/src/
wget http://apache.01link.hk/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar zxf apache-maven-3.3.9-bin.tar.gz
mv apache-maven-3.3.9 /srv/
ln -s /srv/apache-maven-3.3.9 /srv/apache-maven

cat >> /etc/profile.d/apache-maven.sh <<'EOF'
export PATH=/srv/apache-maven/bin:$PATH
EOF

source /etc/profile.d/apache-maven.sh

mvn -v