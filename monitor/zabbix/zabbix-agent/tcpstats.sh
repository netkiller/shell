
mkdir -p /srv/zabbix/libexec
wget https://raw.githubusercontent.com/oscm/zabbix/master/tcpstats/tcpstats -P /srv/zabbix/libexec
wget https://raw.githubusercontent.com/oscm/zabbix/master/tcpstats/userparameter_tcpstats.conf -P /etc/zabbix/zabbix_agentd.d/

chmod +x  /srv/zabbix/libexec/tcpstats

systemctl restart zabbix-agent
