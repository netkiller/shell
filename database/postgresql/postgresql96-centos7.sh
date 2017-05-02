#!/bin/bash

# CentOS 7
yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
yum install -y postgresql96-server postgresql96-contrib

systemctl enable postgresql-9.6
systemctl start postgresql-9.6

cp /var/lib/pgsql/9.6/data/postgresql.conf{,.original}
cp /var/lib/pgsql/9.6/data/pg_hba.conf{,.original}
cp /var/lib/pgsql/9.6/data/pg_ident.conf{,.original}

sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/9.6/data/postgresql.conf

systemctl start postgresql-9.6

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5432 -j ACCEPT
systemctl save iptables