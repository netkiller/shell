#!/bin/bash

cd /usr/local/src/
wget http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz
tar zxf apache-maven-3.6.1-bin.tar.gz
mv apache-maven-3.6.1 /srv/
rm -f /srv/apache-maven
ln -s /srv/apache-maven-3.6.1 /srv/apache-maven

alternatives --install /usr/local/bin/mvn maven /srv/apache-maven-3.6.1/bin/mvn 100

mvn -v
