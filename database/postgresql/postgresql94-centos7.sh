#!/bin/bash

# CentOS 7
yum install -y https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-3.noarch.rpm
yum install -y postgresql94-server postgresql94-contrib

/usr/pgsql-9.4/bin/postgresql94-setup initdb

cp /var/lib/pgsql/9.4/data/postgresql.conf{,.original}
cp /var/lib/pgsql/9.4/data/pg_hba.conf{,.original}
cp /var/lib/pgsql/9.4/data/pg_ident.conf{,.original}



sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/9.4/data/postgresql.conf

systemctl enable postgresql-9.4
systemctl start postgresql-9.4

cp /etc/skel/.bash* /var/lib/pgsql/