#!/bin/sh
dnf install -y https://dev.mysql.com/get/Downloads/MySQL-9.5/mysql-community-common-9.5.0-1.el10.x86_64.rpm
dnf install -y https://dev.mysql.com/get/Downloads/MySQL-9.5/mysql-community-icu-data-files-9.5.0-1.el10.x86_64.rpm
dnf install -y https://dev.mysql.com/get/Downloads/MySQL-9.5/mysql-community-client-plugins-9.5.0-1.el10.x86_64.rpm
dnf install -y https://dev.mysql.com/get/Downloads/MySQL-9.5/mysql-community-libs-9.5.0-1.el10.x86_64.rpm
dnf install -y https://dev.mysql.com/get/Downloads/MySQL-9.5/mysql-community-client-9.5.0-1.el10.x86_64.rpm
dnf install -y https://dev.mysql.com/get/Downloads/MySQL-9.5/mysql-community-server-9.5.0-1.el10.x86_64.rpm

cp /etc/my.cnf{,.original}

cat >>  /etc/security/limits.conf <<EOF

mysql soft nofile 65535
mysql hard nofile 65535
EOF

sed -i "53s/LimitNOFILE = 5000/LimitNOFILE = 65535/g" /usr/lib/systemd/system/mysqld.service

cat >> /etc/my.cnf.d/server.cnf <<EOF
# Add by Neo

[mysqld]
character-set-server=utf8mb4
collation-server=utf8mb4_general_ci
explicit_defaults_for_timestamp=true
lower_case_table_names=1
EOF

systemctl enable mysqld
systemctl start mysqld

grep "A temporary password" /var/log/mysqld.log
