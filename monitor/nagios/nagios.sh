#!/bin/bash
# yum 与 apt 版本过低所以需要编译安装

curl -s https://raw.githubusercontent.com/oscm/shell/master/compiler/gcc.sh | bash

cd /usr/local/src
wget http://softlayer-sng.dl.sourceforge.net/project/nagios/nagios-4.x/nagios-4.0.8/nagios-4.0.8.tar.gz
wget http://nagios-plugins.org/download/nagios-plugins-2.0.3.tar.gz
tar zxf nagios-4.0.8.tar.gz 
tar zxf nagios-plugins-2.0.3.tar.gz 

cd nagios-4.0.8
./configure --prefix=/srv/nagios-4.0.8
make all 
make install && make install-init && make install-commandmode && make install-config
# make install-webconf && make install-exfoliation && make install-classicui

cd /usr/local/src

cd nagios-plugins-2.0.3
./configure --prefix=/srv/nagios-4.0.8 --with-nagios-user=nagios --with-nagios-group=nagios 
make && make install

ln -s /srv/nagios-4.0.8 /srv/nagios
useradd -s /sbin/nologin -d /srv/nagios nagios

chkconfig --add nagios 
chkconfig nagios on
chkconfig --list nagios