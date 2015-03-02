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

sed -i '10iskip-name-resolve' /etc/my.cnf.d/server.cnf 
sed -i '11imax_connections=8192' /etc/my.cnf.d/server.cnf
sed -i '12idefault-storage-engine=INNODB' /etc/my.cnf.d/server.cnf
sed -i '13iwait_timeout=30' /etc/my.cnf.d/server.cnf
sed -i '14iinteractive_timeout=30' /etc/my.cnf.d/server.cnf
sed -i '15icharacter-set-server=utf8' /etc/my.cnf.d/server.cnf
sed -i '16icollation_server=utf8_general_ci' /etc/my.cnf.d/server.cnf
sed -i "17iinit_connect='SET NAMES utf8'" /etc/my.cnf.d/server.cnf
sed -i '18iexplicit_defaults_for_timestamp=true' /etc/my.cnf.d/server.cnf

sed -i '5icharacter_set_client=utf8' /etc/my.cnf.d/client.cnf 

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT
service iptables save