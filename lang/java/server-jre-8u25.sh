#!/bin/bash

cd /usr/local/src/
wget http://download.oracle.com/otn-pub/java/jdk/8u25-b17/server-jre-8u25-linux-x64.tar.gz?AuthParam=1421206431_6b843b3c6afbd75cffe7a14fa80ef41c
tar zxf server-jre-8u25-linux-x64.gz*
mv jdk1.8.0_25 /srv/
ln -s /srv/jdk1.8.0_25 /srv/java

cat >> /etc/profile.d/java.sh <<'EOF'
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms512m -Xmx8192m"
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CATALINA_HOME/lib:
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$CATALINA_HOME/bin:
EOF
