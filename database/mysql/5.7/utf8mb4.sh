#!/bin/sh
cat >> /etc/my.cnf <<EOF
!includedir /etc/my.cnf.d
EOF

cat >> /etc/my.cnf.d/default.cnf <<EOF
[mysqld]
#skip-name-resolve
max_connections=2048
default-storage-engine=INNODB

character-set-server=utf8mb4
collation_server=utf8mb4_unicode_ci
init_connect='SET NAMES utf8mb4'

explicit_defaults_for_timestamp=true

query_cache_type=1
query_cache_size=512M

#sql_mode = STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION

[client]
default-character-set=utf8mb4

EOF
