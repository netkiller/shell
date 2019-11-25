#!/bin/bash

# CentOS 7
dnf install -y https://download.postgresql.org/pub/repos/dnf/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-3.noarch.rpm
dnf install -y postgresql94-server postgresql94-contrib

/usr/pgsql-9.4/bin/postgresql94-setup initdb

cp /var/lib/pgsql/9.4/data/postgresql.conf{,.original}
cp /var/lib/pgsql/9.4/data/pg_hba.conf{,.original}
cp /var/lib/pgsql/9.4/data/pg_ident.conf{,.original}



sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/9.4/data/postgresql.conf

vim /var/lib/pgsql/9.4/data/pg_hba.conf <<VIM > /dev/null 2>&1
:82,82s/ident/md5/
:84,84s/ident/md5/
:wq!
VIM

cat >> /var/lib/pgsql/9.4/data/pg_hba.conf <<EOF

host    all             all             0.0.0.0/0                 md5
EOF

systemctl enable postgresql-9.4
systemctl start postgresql-9.4

cp /etc/skel/.bash* /var/lib/pgsql/