#!/bin/bash
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /var/lib/pgsql/10/data/postgresql.conf
systemctl restart postgresql-10