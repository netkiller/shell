
# Yum php-fpm
sed -i "s/;pm.status_path/pm.status_path/" /etc/php-fpm.d/www.conf
sed -i "s/;ping/ping/" /etc/php-fpm.d/www.conf

systemctl reload php-fpm

mkdir -p /srv/zabbix/libexec
wget https://raw.githubusercontent.com/oscm/zabbix/master/php-fpm/php-fpm.xml.sh -P /srv/zabbix/libexec
wget https://raw.githubusercontent.com/oscm/zabbix/master/php-fpm/userparameter_php-fpm.conf -P /etc/zabbix/zabbix_agentd.d/
wget https://raw.githubusercontent.com/oscm/zabbix/master/php-fpm/default.conf -P /etc/nginx/conf.d

chmod +x  /srv/zabbix/libexec/php-fpm.xml.sh

systemctl reload php-fpm
systemctl restart zabbix-agent
