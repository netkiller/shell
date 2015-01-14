#!/bin/bash

cd /usr/local/src/
wget http://download.oracle.com/otn-pub/java/jdk/7u72-b14/server-jre-7u72-linux-x64.tar.gz?AuthParam=1421206613_d7c0d59e886fd2216bd3ccb12be1cfb5
tar zxf server-jre-7u72-linux-x64.tar.gz*
mv jdk1.7.0_72 /srv/
ln -s /srv/jdk1.7.0_72 /srv/java

cat >> /etc/profile.d/java.sh <<'EOF'
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms512m -Xmx8192m  -XX:PermSize=64M -XX:MaxPermSize=512m"
export CATALINA_HOME=/srv/apache-tomcat
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CATALINA_HOME/lib:
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$CATALINA_HOME/bin:
EOF
