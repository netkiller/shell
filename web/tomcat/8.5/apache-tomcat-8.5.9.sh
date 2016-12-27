#!/bin/bash

cd /usr/local/src/
wget http://apache.communilink.net/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz
tar zxf apache-tomcat-8.5.9.tar.gz

#rm -rf apache-tomcat-8.5.9/webapps/*
rm -rf apache-tomcat-8.5.9/webapps/{docs,examples,manager,ROOT/*}
rm -rf apache-tomcat-8.5.9/logs/*

cp apache-tomcat-8.5.9/conf/server.xml{,.original}
cp apache-tomcat-8.5.9/conf/context.xml{,.original}
cp apache-tomcat-8.5.9/conf/web.xml{,.original}
cp apache-tomcat-8.5.9/conf/logging.properties{,.original}

vim apache-tomcat-8.5.9/conf/server.xml <<VIM > /dev/null 2>&1
:22,22s:port="8005":port="-1":
:70,70s/connectionTimeout="20000"/connectionTimeout="60000"/
:71,71s:/>:maxThreads="4096" enableLookups="false" compression="on" compressionMinSize="2048" compressableMimeType="text/html,text/xml,text/javascript,text/css,text/plain,,application/octet-stream" server="Apache"/>:
:116s/</<!-- </
:116s/>/> -->/
:149,149s/true/false/g
:wq
VIM

sed -i "16s/3manager.org.apache.juli.AsyncFileHandler, 4host-manager.org.apache.juli.AsyncFileHandler,//" apache-tomcat-8.5.9/conf/logging.properties

mkdir -p apache-tomcat-8.5.9/lib/org/apache/catalina/util

cat >> apache-tomcat-8.5.9/lib/org/apache/catalina/util/ServerInfo.properties <<EOF
server.info=Apache
server.number=
server.built=
EOF

cat > apache-tomcat-8.5.9/bin/setenv.sh <<'EOF'
JRE_HOME=/srv/java
JAVA_HOME=/srv/java
JAVA_OPTS="-server -Xms2048m -Xmx4096m -Djava.security.egd=file:/dev/./urandom"
CLASSPATH=$JAVA_HOME/lib:$CLASSPATH:
PATH=$PATH:$JAVA_HOME/bin:
EOF

mv apache-tomcat-8.5.9 /srv/
chown www:www -R /srv/apache-tomcat-8.5.9

cd /srv/