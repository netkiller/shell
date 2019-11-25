#!/bin/bash

dnf install redis -y

cp /etc/redis.conf{,.original}
sed -i 's/daemonize no/daemonize yes/' /etc/redis.conf 
# sed -i 's/timeout 0/timeout 30/' /etc/redis.conf
sed -i 's/tcp-keepalive 0/tcp-keepalive 60/' /etc/redis.conf 
sed -i 's/# maxclients 10000/maxclients 10000/' /etc/redis.conf
sed -i 's/# maxmemory-policy noeviction/maxmemory-policy volatile-lru/g' /usr/local/etc/redis.conf


cat >> /etc/sysctl.conf <<EOF
# Set up for Redis
vm.overcommit_memory = 1
net.core.somaxconn = 1024
EOF

sysctl -w net.core.somaxconn=1024
sysctl -w vm.overcommit_memory=1

cat >> /etc/rc.local  <<EOF

# Set up for Redis
echo never > /sys/kernel/mm/transparent_hugepage/enabled
EOF

echo never > /sys/kernel/mm/transparent_hugepage/enabled

systemctl enable redis
systemctl start redis
systemctl status redis

