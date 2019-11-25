#!/bin/bash
##################################################
# Author: Neo <netkiller@msn.com>
# Website http://netkiller.github.io
##################################################
dnf localinstall -y http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm

dnf install -y zabbix-agent

cp /etc/zabbix/zabbix_agentd.conf{,.original}

#sed -i "s/# SourceIP=/SourceIP=<Zabbix Server IP Address>/" /etc/zabbix/zabbix_agentd.conf
#sed -i "s/Server=127.0.0.1/Server=<Zabbix Server IP Address>/" /etc/zabbix/zabbix_agentd.conf
#sed -i "s/ServerActive=127.0.0.1/ServerActive=<Zabbix Server IP Address>/" /etc/zabbix/zabbix_agentd.conf
#sed -i "s/Hostname=Zabbix server/Hostname=<Your hostname>/" /etc/zabbix/zabbix_agentd.conf

systemctl enable zabbix-agent.service
systemctl start zabbix-agent.service

# /etc/sysconfig/iptables
# -A INPUT -s <Zabbix Server IP Address> -p tcp -m state --state NEW -m tcp --dport 10050 -j ACCEPT

