#!/bin/bash

cat > /etc/dnf.repos.d/MariaDB.repo <<EOF
# MariaDB 10.0 CentOS repository list - created 2015-02-06 05:28 UTC
# http://mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://dnf.mariadb.org/10.0/centos7-amd64
gpgkey=https://dnf.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF
