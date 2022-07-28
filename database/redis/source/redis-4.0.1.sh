#!/bin/bash
##################################################
# Redis 4.0.1 setup script
# Author: netkiller<netkiller@msn.com>
# Website: http://www.netkiller.cn
##################################################
cd /usr/local/src

adduser redis

wget http://download.redis.io/releases/redis-4.0.1.tar.gz
tar xzf redis-4.0.1.tar.gz
cd redis-4.0.1
make MALLOC=libc -j$(getconf _NPROCESSORS_ONLN) && make install

cp redis.conf /usr/local/etc/
cp /usr/local/etc/redis.conf{,.original}
sed -i 's/daemonize no/daemonize yes/' /usr/local/etc/redis.conf
# sed -i 's/timeout 0/timeout 30/' /usr/local/etc/redis.conf
# sed -i 's/tcp-keepalive 0/tcp-keepalive 120/' /usr/local/etc/redis.conf
sed -i 's/# maxclients 10000/maxclients 10000/' /usr/local/etc/redis.conf
sed -i 's/# maxmemory-policy noeviction/maxmemory-policy volatile-lru/g' /usr/local/etc/redis.conf
sed -i 's#^dir ./#dir /var/lib/redis#' /usr/local/etc/redis.conf

mkdir /var/lib/redis
touch /var/log/redis.log
chown redis:redis /var/lib/redis /var/log/redis.log

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

wget -q https://raw.githubusercontent.com/netkiller/shell/master/database/redis/source/systemd/redis.service -O /usr/lib/systemd/system/redis.service
wget -q https://raw.githubusercontent.com/netkiller/shell/master/database/redis/source/systemd/redis-shutdown -O /usr/local/bin/redis-shutdown
chmod 700 /usr/local/bin/redis-shutdown
chown redis:redis /usr/local/bin/redis-shutdown

systemctl enable redis
systemctl start redis
systemctl status redis

