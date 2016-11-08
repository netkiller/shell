#!/bin/bash

cd /usr/local/src/
wget http://apache.website-solution.net/tomcat/tomcat-8/v8.5.6/bin/apache-tomcat-8.5.6.tar.gz
tar zxf apache-tomcat-8.5.6.tar.gz

#rm -rf apache-tomcat-8.5.6/webapps/*
rm -rf apache-tomcat-8.5.6/webapps/{docs,examples,manager,ROOT/*}
rm -rf apache-tomcat-8.5.6/logs/*

cp apache-tomcat-8.5.6/conf/server.xml{,.original}
cp apache-tomcat-8.5.6/conf/context.xml{,.original}
cp apache-tomcat-8.5.6/conf/web.xml{,.original}
cp apache-tomcat-8.5.6/conf/logging.properties{,.original}

vim apache-tomcat-8.5.6/conf/server.xml <<VIM > /dev/null 2>&1
:22,22s:port="8005":port="-1":
:71,71s:/>:maxThreads="4096" enableLookups="false" compression="on" compressionMinSize="2048" compressableMimeType="text/html,text/xml,text/javascript,text/css,text/plain,,application/octet-stream" server="Apache"/>:
:111s/</<!-- </
:111s/>/> -->/
:144,144s/true/false/g
:wq
VIM

sed -i "16s/3manager.org.apache.juli.AsyncFileHandler, 4host-manager.org.apache.juli.AsyncFileHandler,//" apache-tomcat-8.5.6/conf/logging.properties

mkdir -p apache-tomcat-8.5.6/lib/org/apache/catalina/util

cat >> apache-tomcat-8.5.6/lib/org/apache/catalina/util/ServerInfo.properties <<EOF
server.info=Apache
server.number=
server.built=
EOF

cat > apache-tomcat-8.5.6/bin/setenv.sh <<'EOF'
JRE_HOME=/srv/java
JAVA_HOME=/srv/java
JAVA_OPTS="-server -Xms2048m -Xmx4096m -Djava.security.egd=file:/dev/./urandom"
#CATALINA_HOME=/srv/apache-tomcat-8.5.6
#LD_LIBRARY_PATH=$CATALINA_HOME/lib
#CATALINA_OPTS=" -Djava.awt.headless=true -Djava.library.path=$LD_LIBRARY_PATH"
CLASSPATH=$JAVA_HOME/lib:$CLASSPATH:
PATH=$PATH:$JAVA_HOME/bin:
EOF

mv apache-tomcat-8.5.6 /srv/
chown www:www -R /srv/apache-tomcat-8.5.6

cd /srv/