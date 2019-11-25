#!/bin/bash

dnf install cacti

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