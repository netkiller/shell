wget https://raw.githubusercontent.com/netkiller/zabbix/master/redis/userparameter_redis.conf -P /etc/zabbix/zabbix_agentd.d/

systemctl restart zabbix-agent
