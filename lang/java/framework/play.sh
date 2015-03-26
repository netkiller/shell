#!/bin/bash

cd /usr/local/src/

wget http://downloads.typesafe.com/typesafe-activator/1.3.2/typesafe-activator-1.3.2-minimal.zip

unzip typesafe-activator-1.3.2-minimal.zip 

mv activator-1.3.2-minimal /srv/
ln -s activator-1.3.2-minimal /srv/activator

cat >> /etc/profile.d/activator.sh <<'EOF'
export PATH=$PATH:/srv/activator
EOF
