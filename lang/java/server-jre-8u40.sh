#!/bin/bash

cd /usr/local/src/
wget http://download.oracle.com/otn-pub/java/jdk/8u40-b26/server-jre-8u40-linux-x64.tar.gz?AuthParam=1427703756_960786b5c2b7cb90e20758efaec150da
tar zxf server-jre-8u40-linux-x64.tar.gz*
mv jdk1.8.0_40 /srv/
ln -s /srv/jdk1.8.0_40 /srv/java

cat >> /etc/profile.d/java.sh <<'EOF'
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms512m -Xmx8192m"
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:.
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:
EOF

sed -i '117s/securerandom.source/#securerandom.source/' /srv/java/jre/lib/security/java.security
sed -i '118isecurerandom.source=file:/dev/./urandom' /srv/java/jre/lib/security/java.security

cat >> /etc/man.config <<EOF
MANPATH  /srv/java/man
EOF
