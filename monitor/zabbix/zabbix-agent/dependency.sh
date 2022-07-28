
mkdir -p /srv/zabbix/libexec
wget https://raw.githubusercontent.com/netkiller/zabbix/master/Dependency/dependency -P /srv/zabbix/libexec
wget https://raw.githubusercontent.com/netkiller/zabbix/master/Dependency/userparameter_dependency.conf -P /etc/zabbix/zabbix_agentd.d/

chmod +x  /srv/zabbix/libexec/dependency

mkdir -p /srv/zabbix/conf
cat >> /srv/zabbix/conf/dependency.conf << EOF
Redis 127.0.0.1 80
EOF

systemctl restart zabbix-agent
