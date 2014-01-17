#!/bin/sh
yum localinstall http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
yum install mysql-server -y
chkconfig mysqld on
service mysqld start