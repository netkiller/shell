#!/bin/bash

cd /usr/local/src/
wget http://ftp.cuhk.edu.hk/pub/packages/apache.org/tomcat/tomcat-7/v7.0.67/bin/apache-tomcat-7.0.67.tar.gz
tar zxf apache-tomcat-7.0.67.tar.gz 

mv apache-tomcat-7.0.67 /srv/
rm -f /srv/apache-tomcat
ln -s /srv/apache-tomcat-7.0.67 /srv/apache-tomcat
#rm -rf /srv/apache-tomcat/webapps/*
rm -rf  /srv/apache-tomcat/webapps/{docs,examples,host-manager,ROOT/*}
rm -rf /srv/apache-tomcat/logs/*

cp /srv/apache-tomcat/conf/server.xml{,.original}
cp /srv/apache-tomcat/conf/context.xml{,.original}
cp /srv/apache-tomcat/conf/web.xml{,.original}

chown www:www -R /srv/apache-tomcat-*

vim /srv/apache-tomcat/conf/server.xml <<VIM > /dev/null 2>&1
:73,73s:/>:maxThreads="4096" enableLookups="false" compression="on" compressionMinSize="2048" compressableMimeType="text/html,text/xml,text/javascript,text/css,text/plain,application/octet-stream" server="Apache"/>:
:93s/</<!-- </
:93s/>/> -->/
:126,126s/true/false/g
:wq
VIM

sed -i "16s/3manager.org.apache.juli.FileHandler, 4host-manager.org.apache.juli.FileHandler,//" /srv/apache-tomcat/conf/logging.properties