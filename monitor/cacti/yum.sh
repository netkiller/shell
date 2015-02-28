#!/bin/bash

yum install cacti

cp /etc/cacti/db.php{,.original}
cp /etc/httpd/conf.d/cacti.conf{,.original}

#Create MySQL Cacti Database
# mysql -u root -p
#mysql> create database cacti;
#mysql> GRANT ALL ON cacti.* TO cacti@localhost IDENTIFIED BY 'cacti';
#mysql> FLUSH privileges;
#mysql> quit;

mysql -ucacti -pcacti cacti < /usr/share/doc/cacti-0.8.8b/cacti.sql

vim /etc/cacti/db.php <<VIM > /dev/null 2>&1
:29,29s/cactiuser/cacti/
:30,30s/cactiuser/cacti/
:wq
VIM

sed -i 's/^#//' /etc/cron.d/cacti

service httpd reload

cd /usr/local/src
wget http://docs.cacti.net/_media/plugin:monitor-v1.3-1.tgz
wget http://docs.cacti.net/_media/plugin:errorimage-v0.2-1.tgz
wget http://docs.cacti.net/_media/plugin:discovery-v1.5-1.tgz


mv plugin\:monitor-v1.3-1.tgz monitor-v1.3-1.tgz
mv plugin\:errorimage-v0.2-1.tgz errorimage-v0.2-1.tgz 

tar zxf monitor-v1.3-1.tgz -C /usr/share/cacti/plugins
tar zxf errorimage-v0.2-1.tgz -C /usr/share/cacti/plugins
