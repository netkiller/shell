dnf install https://download.postgresql.org/pub/repos/dnf/11/redhat/rhel-7-x86_64/pgdg-centos11-11-2.noarch.rpm
dnf install postgresql11
dnf install postgresql11-server

/usr/pgsql-11/bin/postgresql-11-setup initdb

sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/9.4/data/postgresql.conf

vim /var/lib/pgsql/11/data/pg_hba.conf <<VIM > /dev/null 2>&1
:82,82s/ident/md5/
:84,84s/ident/md5/
:wq!
VIM

cat >> /var/lib/pgsql/11/data/pg_hba.conf <<EOF

host    all             all             0.0.0.0/0                 md5
EOF

systemctl enable postgresql-11
systemctl start postgresql-11