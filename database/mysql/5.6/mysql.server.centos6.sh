#!/bin/sh
dnf localinstall -y http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
dnf update -y
dnf install mysql-server -y
chkconfig mysqld on
service mysqld start

cp /etc/my.cnf{,.original}

cat >> /etc/security/limits.d/80-mysql.conf <<EOF

mysql soft nofile 40960
mysql hard nofile 40960
EOF

cat >> /etc/my.cnf.d/default.cnf <<EOF
[mysqld]
skip-name-resolve
max_connections=8192
default-storage-engine=INNODB

#wait_timeout=30
#interactive_timeout=30

character-set-server=utf8
collation_server=utf8_general_ci
init_connect='SET NAMES utf8'

explicit_defaults_for_timestamp=true

query_cache_type=1
query_cache_size=512M

[client]
character_set_client=utf8

EOF

# /usr/bin/mysqladmin -u root password 'new-password'
# /usr/bin/mysql_secure_installation