#!/bin/bash

# CentOS 7
yum install -y http://yum.postgresql.org/9.3/redhat/rhel-7-x86_64/pgdg-centos93-9.3-1.noarch.rpm
yum install -y postgresql93-server postgresql93-contrib

systemctl initdb postgresql-9.3
chkconfig postgresql-9.3 on

cp /var/lib/pgsql/9.3/data/postgresql.conf{,.original}
cp /var/lib/pgsql/9.3/data/pg_hba.conf{,.original}
cp /var/lib/pgsql/9.3/data/pg_ident.conf{,.original}

sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/9.3/data/postgresql.conf

systemctl start postgresql-9.3

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5432 -j ACCEPT
systemctl save iptables