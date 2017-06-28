#!/bin/bash

cd /usr/local/src/
curl -LO -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/server-jre-8u131-linux-x64.tar.gz
tar zxf server-jre-8u131-linux-x64.tar.gz*
mv jdk1.8.0_131 /srv/
ln -s /srv/jdk1.8.0_131 /srv/java

cat >> /etc/profile.d/java.sh <<'EOF'
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms2048m -Xmx4096m"
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:.
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:
EOF

cat >> /etc/man.config <<EOF
MANPATH  /srv/java/man
EOF

cp /srv/java/jre/lib/security/java.security{,.original}

# securerandom.source=file:/dev/random
sed -i '117s/random/urandom/g' /srv/java/jre/lib/security/java.security


