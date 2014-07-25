#!/bin/sh
yum localinstall -y http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
yum update -y
yum install mysql-server -y
chkconfig mysqld on
service mysqld start

cp /etc/my.cnf{,.original}

cat >> /etc/security/limits.d/80-mysql.conf <<EOF

mysql soft nofile 40960
mysql hard nofile 40960
EOF