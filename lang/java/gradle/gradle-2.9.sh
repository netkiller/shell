#!/bin/bash

cd /usr/local/src/
wget https://services.gradle.org/distributions/gradle-2.9-bin.zip
unzip gradle-2.9-bin.zip
mv gradle-2.9 /srv/
ln -s /srv/gradle-2.9 /srv/gradle

cat >> /etc/profile.d/gradle.sh <<'EOF'
export GRADLE_HOME=/srv/gradle
export PATH=$GRADLE_HOME/bin:$PATH
EOF

source /etc/profile.d/gradle.sh

gradle -v