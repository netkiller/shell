#!/bin/bash

cd /usr/local/src/

tar zxvf server-jre-7u25-linux-x64.tar.gz
mv jdk1.7.0_25 /srv/
ln -s /srv/jdk1.7.0_25 /srv/java

cat >> ~/.bash_profile <<'EOF'
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms512m -Xmx8192m  -XX:PermSize=64M -XX:MaxPermSize=512m"
export CATALINA_HOME=/srv/apache-tomcat
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CATALINA_HOME/lib:
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$CATALINA_HOME/bin:
EOF
