
mkdir -p /srv/zabbix/libexec
wget https://raw.githubusercontent.com/oscm/zabbix/master/nginx/nginx.sh -P /srv/zabbix/libexec
wget https://raw.githubusercontent.com/oscm/zabbix/master/nginx/userparameter_nginx.conf -P /etc/zabbix/zabbix_agentd.d/
wget https://raw.githubusercontent.com/oscm/zabbix/master/nginx/default.conf -P /etc/nginx/conf.d

chmod +x  /srv/zabbix/libexec/nginx.sh

systemctl reload nginx
systemctl restart zabbix-agent
