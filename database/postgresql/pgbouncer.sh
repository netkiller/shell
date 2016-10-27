#!/bin/bash

yum install -y pgbouncer

cp /etc/pgbouncer/pgbouncer.ini{,.original}

sed -i "23,23imain = host=localhost port=5432 dbname=test user=test password=test connect_query='SELECT 1'" /etc/pgbouncer/pgbouncer.ini
sed -i "41,41s/listen_port = 6432/listen_port = 1521/" /etc/pgbouncer/pgbouncer.ini

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 1521 -j ACCEPT
service iptables save