#!/bin/bash

cd /usr/local/src/
wget http://mirror.bit.edu.cn/apache/tomcat/tomcat-8/v8.5.16/bin/apache-tomcat-8.5.16.tar.gz
tar zxf apache-tomcat-8.5.16.tar.gz

cp apache-tomcat-8.5.16/conf/server.xml{,.original}
cp apache-tomcat-8.5.16/conf/context.xml{,.original}
cp apache-tomcat-8.5.16/conf/web.xml{,.original}
cp apache-tomcat-8.5.16/conf/tomcat-users.xml{,.original}
cp apache-tomcat-8.5.16/conf/logging.properties{,.original}

vim apache-tomcat-8.5.16/conf/server.xml <<VIM > /dev/null 2>&1
:22,22s:port="8005":port="-1":
:28,28s:SSLEngine="on":SSLEngine="off"
:70,70s/connectionTimeout="20000"/connectionTimeout="60000"/
:71,71s:/>:maxThreads="4096" enableLookups="false" compression="on" compressionMinSize="1024" compressableMimeType="text/html,text/xml,text/javascript,text/css,text/plain,,application/octet-stream" server="Apache"/>:
:116s/</<!-- </
:116s/>/> -->/
:149,149s/true/false/g
:wq
VIM

#:144s/</<!-- </
#:146s/>/> -->/
#:139s/</<!-- </
#:139s/>/> -->/

rm -rf apache-tomcat-8.5.16/webapps/*
#rm -rf apache-tomcat-8.5.16/webapps/{docs,examples,manager,host-manager,ROOT/*}
rm -rf apache-tomcat-8.5.16/logs/*

cat <<EOF> apache-tomcat-8.5.16/conf/tomcat-users.xml
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users xmlns="http://tomcat.apache.org/xml"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
              version="1.0">
</tomcat-users>
EOF

sed -i "16s/3manager.org.apache.juli.AsyncFileHandler, 4host-manager.org.apache.juli.AsyncFileHandler,//" apache-tomcat-8.5.16/conf/logging.properties

mkdir -p apache-tomcat-8.5.16/lib/org/apache/catalina/util

cat >> apache-tomcat-8.5.16/lib/org/apache/catalina/util/ServerInfo.properties <<EOF
server.info=Apache
server.number=
server.built=
EOF

cat > apache-tomcat-8.5.16/bin/setenv.sh <<'EOF'
JRE_HOME=/srv/java
JAVA_HOME=/srv/java
JAVA_OPTS="-server -Xms2048m -Xmx4096m -Djava.security.egd=file:/dev/./urandom"
CLASSPATH=$JAVA_HOME/lib:$CLASSPATH:
PATH=$PATH:$JAVA_HOME/bin:
EOF

mkdir -p /srv/apache-tomcat
mv apache-tomcat-8.5.16 /srv/apache-tomcat/
chmod 755 -R /srv/apache-tomcat/apache-tomcat-8.5.16
chown root:root -R /srv/apache-tomcat/apache-tomcat-8.5.16
mkdir /srv/apache-tomcat/apache-tomcat-8.5.16/conf/Catalina
chown www:www -R /srv/apache-tomcat/apache-tomcat-8.5.16/{logs,temp,work,/conf/Catalina}

cd /srv/apache-tomcat
