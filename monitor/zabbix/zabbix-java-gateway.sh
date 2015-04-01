#!/bin/bash

yum install -y zabbix-java-gateway

cp /etc/zabbix/zabbix_java_gateway.conf{,.original}

vim /etc/zabbix/zabbix_java_gateway.conf <<EOF > /dev/null 2>&1
:%s/# LISTEN_IP/LISTEN_IP/
:%s/# LISTEN_PORT/LISTEN_PORT/
:%s/# START_POLLERS/START_POLLERS/
:wq
EOF

systemctl enable zabbix-java-gateway.service
systemctl start zabbix-java-gateway.service
systemctl restart zabbix-server