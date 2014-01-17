#!/bin/sh
yum localinstall -y http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
yum install mysql-server -y
chkconfig mysqld on
service mysqld start

cp /etc/my.cnf{,.original}
