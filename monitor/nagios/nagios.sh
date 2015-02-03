#!/bin/bash
# yum 与 apt 版本过低所以需要编译安装

curl -s https://raw.githubusercontent.com/oscm/shell/master/compiler/gcc.sh | bash

curl -s https://raw.githubusercontent.com/oscm/shell/master/web/httpd/httpd.yum.sh | bash

cd /usr/local/src
wget http://softlayer-sng.dl.sourceforge.net/project/nagios/nagios-4.x/nagios-4.0.8/nagios-4.0.8.tar.gz
wget http://nagios-plugins.org/download/nagios-plugins-2.0.3.tar.gz
tar zxf nagios-4.0.8.tar.gz 
tar zxf nagios-plugins-2.0.3.tar.gz 

cd nagios-4.0.8
./configure --prefix=/srv/nagios-4.0.8
make all 
make install && make install-init && make install-commandmode && make install-config
make install-webconf 
# && make install-exfoliation && make install-classicui

htpasswd -c /srv/nagios-4.0.8/etc/htpasswd.users nagiosadmin
chown apache:apache /srv/nagios-4.0.8/etc/htpasswd.users
chmod 600 /srv/nagios-4.0.8/etc/htpasswd.users

cp /srv/nagios-4.0.8/etc/nagios.cfg{,.original}
cp /srv/nagios-4.0.8/etc/cgi.cfg{,.original}
cp /srv/nagios-4.0.8/etc/objects/commands.cfg{,.original}
cp /srv/nagios-4.0.8/etc/objects/contacts.cfg{,.original}

cd /usr/local/src

cd nagios-plugins-2.0.3
./configure --prefix=/srv/nagios-4.0.8 --with-nagios-user=nagios --with-nagios-group=nagios 
make && make install

ln -s /srv/nagios-4.0.8 /srv/nagios
useradd -s /sbin/nologin -d /srv/nagios nagios

chkconfig --add nagios 
chkconfig nagios on
chkconfig --list nagios

systemctl restart httpd

# enable audio files
vim /srv/nagios-4.0.8/etc/cgi.cfg <<VIM > /dev/null 2>&1
:312,317s/#//g
:wq
VIM
