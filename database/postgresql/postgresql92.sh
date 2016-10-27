#!/bin/bash

yum install http://yum.postgresql.org/9.2/redhat/rhel-6-x86_64/pgdg-centos92-9.2-6.noarch.rpm
yum install postgresql92-server postgresql92 postgresql92-contrib

chkconfig postgresql-9.2 on
service postgresql-9.2 initdb
service postgresql-9.2 start

cp /var/lib/pgsql/9.2/data/postgresql.conf{,.original}
cp /var/lib/pgsql/9.2/data/pg_hba.conf{,.original}
cp /var/lib/pgsql/9.2/data/pg_ident.conf{,.original}

sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/9.2/data/postgresql.conf

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5432 -j ACCEPT
service iptables save