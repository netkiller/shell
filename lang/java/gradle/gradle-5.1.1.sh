#!/bin/bash

cd /usr/local/src/
wget https://services.gradle.org/distributions/gradle-5.1.1-bin.zip
unzip gradle-5.1.1-bin.zip
mv gradle-5.1.1 /srv/
ln -s /srv/gradle-5.1.1 /srv/gradle

cat >> /etc/profile.d/gradle.sh <<'EOF'
export GRADLE_HOME=/srv/gradle
export PATH=$GRADLE_HOME/bin:$PATH
EOF

source /etc/profile.d/gradle.sh

gradle -v