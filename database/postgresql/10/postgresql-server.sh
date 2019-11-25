#!/bin/bash
dnf install -y postgresql10-server postgresql10-contrib

/usr/pgsql-10/bin/postgresql10-setup initdb

cp /var/lib/pgsql/10/data/postgresql.conf{,.original}
cp /var/lib/pgsql/10/data/pg_hba.conf{,.original}
cp /var/lib/pgsql/10/data/pg_ident.conf{,.original}

systemctl enable postgresql-10
systemctl start postgresql-10

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 5432 -j ACCEPT
systemctl save iptables