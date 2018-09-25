#!/bin/bash

cd /usr/local/src/
#wget http://download.oracle.com/otn-pub/java/jdk/8u40-b26/server-jre-8u40-linux-x64.tar.gz?AuthParam=1427703756_960786b5c2b7cb90e20758efaec150da
tar xf serverjre-10.0.2_linux-x64_bin.tar*
mv jdk-10.0.2 /srv/
ln -s /srv/jdk-10.0.2 /srv/java

cat >> /etc/profile.d/java.sh <<'EOF'
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms512m -Xmx8192m"
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:.
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:
EOF

#sed -i '117s/securerandom.source/#securerandom.source/' /srv/java/conf/security/java.security
#sed -i '118isecurerandom.source=file:/dev/./urandom' /srv/java/conf/security/java.security
sed -i '150s|/dev/random|/dev/urandom|' /srv/java/conf/security/java.security

cat >> /etc/man.config <<EOF
MANPATH  /srv/java/man
EOF