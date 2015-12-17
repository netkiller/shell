#!/bin/bash

yum install -y apr-devel

cd /usr/local/src/
wget http://apache.01link.hk/tomcat/tomcat-connectors/native/1.1.34/source/tomcat-native-1.1.34-src.tar.gz
tar zxvf tomcat-native-1.1.34-src.tar.gz
cd tomcat-native-1.1.34-src/jni/native

./configure --prefix=/srv/tomcat-native-1.1.34 --with-apr=/usr/bin/apr-1-config --with-ssl=/usr/bin/openssl  --with-java-home=/srv/java
make 
make install