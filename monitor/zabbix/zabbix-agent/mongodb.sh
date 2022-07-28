
mkdir -p /srv/zabbix/libexec
wget https://raw.githubusercontent.com/netkiller/zabbix/master/mongodb/mongodb.sh -P /srv/zabbix/libexec
wget https://raw.githubusercontent.com/netkiller/zabbix/master/mongodb/userparameter_mongodb.conf -P /etc/zabbix/zabbix_agentd.d/

chmod +x  /srv/zabbix/libexec/mongodb.sh

systemctl restart zabbix-agent
