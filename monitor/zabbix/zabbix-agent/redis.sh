wget https://raw.githubusercontent.com/oscm/zabbix/master/redis/userparameter_redis.conf -P /etc/zabbix/zabbix_agentd.d/

systemctl restart zabbix-agent
