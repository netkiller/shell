
#!/bin/sh

if [ -z $(rpm -qa mysql80-community-release) ]; then
    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/8.0/mysql80-community-release.sh | bash
fi

yum install -y mysql-community-server

cp /etc/my.cnf{,.original}

cat >>  /etc/security/limits.conf <<EOF

mysql soft nofile 65535
mysql hard nofile 65535
EOF


sed -i "53s/LimitNOFILE = 5000/LimitNOFILE = 65535/g" /usr/lib/systemd/system/mysqld.service

systemctl enable mysqld
systemctl start mysqld

grep "A temporary password" /var/log/mysqld.log
