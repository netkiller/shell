#!/bin/bash
##################################################
# Author: Neo <netkiller@msn.com>
# Website http://netkiller.github.io
##################################################
yum localinstall -y http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm

yum install -y zabbix-server-mysql zabbix-web-mysql

# CREATE DATABASE `zabbix` /*!40100 COLLATE 'utf8_general_ci' */

zcat /usr/share/doc/zabbix-server-mysql-3.2.1/create.sql.gz | mysql -uzabbix -p zabbix

cp /etc/zabbix/zabbix_server.conf{,.original}
vim /etc/zabbix/zabbix_server.conf <<EOF > /dev/null 2>&1
:%s/# DBPassword=/DBPassword=your_password/
:wq
EOF

systemctl enable httpd
systemctl enable zabbix-server
systemctl enable zabbix-agent

systemctl start zabbix-server
systemctl start zabbix-agent
systemctl restart httpd

# setup
# http://localhost/zabbix/

