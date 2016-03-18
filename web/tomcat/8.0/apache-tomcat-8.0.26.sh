#!/bin/bash

cd /usr/local/src/
wget http://apache.communilink.net/tomcat/tomcat-8/v8.0.26/bin/apache-tomcat-8.0.26.tar.gz
tar zxf apache-tomcat-8.0.26.tar.gz 

mv apache-tomcat-8.0.26 /srv/
rm -f /srv/apache-tomcat
ln -s /srv/apache-tomcat-8.0.26 /srv/apache-tomcat
#rm -rf /srv/apache-tomcat/webapps/*
rm -rf  /srv/apache-tomcat/webapps/{docs,examples,host-manager,ROOT/*}
rm -rf /srv/apache-tomcat/logs/*

cp /srv/apache-tomcat/conf/server.xml{,.original}
cp /srv/apache-tomcat/conf/context.xml{,.original}
cp /srv/apache-tomcat/conf/web.xml{,.original}
cp /srv/apache-tomcat/conf/logging.properties{,.original}

chown www:www -R /srv/apache-tomcat-*

vim /srv/apache-tomcat/conf/server.xml <<VIM > /dev/null 2>&1
:22,22s:port="8005":port="-1":
:71,71s:/>:maxThreads="4096" enableLookups="false" compression="on" compressionMinSize="2048" compressableMimeType="text/html,text/xml,text/javascript,text/css,text/plain,,application/octet-stream" server="Apache"/>:
:91s/</<!-- </
:91s/>/> -->/
:124,124s/true/false/g
:wq
VIM

sed -i "16s/3manager.org.apache.juli.FileHandler, 4host-manager.org.apache.juli.FileHandler,//" /srv/apache-tomcat/conf/logging.properties

