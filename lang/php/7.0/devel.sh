#!/bin/bash

#dnf install -y gcc gcc-c++ make patch automake autoconf \
dnf install -y systemd-devel libacl-devel curl-devel libmcrypt-devel mhash-devel gd-devel libjpeg-devel libpng-devel libXpm-devel libxml2-devel libxslt-devel openssl-devel recode-devel 
#dnf install openldap-devel net-snmp-devel

dnf localinstall -y http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
dnf install mysql-community-devel -y

dnf install -y http://dnf.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm
dnf install -y postgresql94-devel
