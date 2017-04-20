#!/bin/bash
yum install -y postgresql10-server postgresql10-contrib

systemctl initdb postgresql-10
chkconfig postgresql-10 on

cp /var/lib/pgsql/10/data/postgresql.conf{,.original}
cp /var/lib/pgsql/10/data/pg_hba.conf{,.original}
cp /var/lib/pgsql/10/data/pg_ident.conf{,.original}

sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/10/data/postgresql.conf

systemctl start postgresql-10

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5432 -j ACCEPT
systemctl save iptables