#!/bin/bash

cd /usr/local/src/
wget http://download.oracle.com/otn-pub/java/jdk/10.0.2+13/19aef61b38124481863b1413dce1855f/serverjre-10.0.2_linux-x64_bin.tar.gz?AuthParam=1537857961_d1cacae4e6a9a9c244f2daad158fdd27
tar xf serverjre-10.0.2_linux-x64_bin.tar*
mv jdk-10.0.2 /srv/
ln -s /srv/jdk-10.0.2 /srv/java

#sed -i '117s/securerandom.source/#securerandom.source/' /srv/java/conf/security/java.security
#sed -i '118isecurerandom.source=file:/dev/./urandom' /srv/java/conf/security/java.security
sed -i '150s|/dev/random|/dev/urandom|' /srv/java/conf/security/java.security

cat >> /etc/profile.d/java.sh <<'EOF'
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms512m -Xmx8192m"
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:.
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:
EOF

source /etc/profile.d/java.sh

cat >> /etc/man.config <<EOF
MANPATH  /srv/java/man
EOF