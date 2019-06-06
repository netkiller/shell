#!/bin/bash

cd /usr/local/src/
wget https://www.apache.org/dist/ant/binaries/apache-ant-1.10.6-bin.tar.xz
tar Jxf apache-ant-1.10.6-bin.tar.xz
mv apache-ant-1.10.6 /srv
rm -f /srv/apache-ant
ln -s /srv/apache-ant-1.10.6 /srv/apache-ant

alternatives --install /usr/local/bin/ant ant /srv/apache-ant-1.10.6/bin/ant 100

ant -version