#!/bin/sh
yum localinstall -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum install mysql-community-server -y

grep "A temporary password" /var/log/mysqld.log

cp /etc/my.cnf{,.original}

cat >> /etc/security/limits.d/20-nofile.conf <<EOF

mysql soft nofile 65535
mysql hard nofile 65535
EOF

cat >> /etc/my.cnf <<EOF
!includedir /etc/my.cnf.d
EOF

cat >> /etc/my.cnf.d/default.cnf <<EOF
[mysqld]
explicit_defaults_for_timestamp = 1

skip-name-resolve
max_connections=2048
default-storage-engine=INNODB

#wait_timeout=300
#interactive_timeout=300

character-set-server=utf8
collation_server=utf8_general_ci
init_connect='SET NAMES utf8'

explicit_defaults_for_timestamp=true

query_cache_type=1
query_cache_size=512M
max_open_files=10240
table-open-cache=2000

# MySQL 5.7.20 disabled
#validate_password_policy=0
#validate_password_length=6

sql_mode = STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION

[client]
#character_set_client=utf8
default-character-set=utf8

EOF

# 5.7.17 已经废弃 validate-password=OFF

# /usr/bin/mysqladmin -u root password 'new-password'
# /usr/bin/mysql_secure_installation


systemctl enable mysqld
systemctl start mysqld
