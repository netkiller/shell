#!/bin/bash

sudo -i
yum install MariaDB-server MariaDB-client

chkconfig mysql on
service mysql start

#'/usr/bin/mysqladmin' -u root password 'new-password'
#'/usr/bin/mysqladmin' -u root -h localhost.localdomain password 'new-password'
#'/usr/bin/mysql_secure_installation'

cp /etc/my.cnf{,.original}
cp /etc/my.cnf.d/server.cnf{,.original}
cp /etc/my.cnf.d/client.cnf{,.original}

#sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis.conf 
#sed -i 's/# requirepass foobared/requirepass passw0rd/g' /etc/redis.conf 

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT
service iptables save

