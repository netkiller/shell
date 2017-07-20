#!/bin/bash

cd /usr/local/src/
wget http://apache.website-solution.net/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
tar zxf apache-maven-3.5.0-bin.tar.gz
mv apache-maven-3.5.0 /srv/
rm -f /srv/apache-maven
ln -s /srv/apache-maven-3.5.0 /srv/apache-maven

cat >> /etc/profile.d/apache-maven.sh <<'EOF'
export PATH=/srv/apache-maven/bin:$PATH
EOF

source /etc/profile.d/apache-maven.sh

mvn -v
