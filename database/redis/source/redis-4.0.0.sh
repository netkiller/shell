#!/bin/bash
##################################################
# Redis 4.0.0 setup script
# Author: netkiller<netkiller@msn.com>
# Website: http://www.netkiller.cn
##################################################
cd /usr/local/src

adduser redis

wget http://download.redis.io/releases/redis-4.0.0.tar.gz
tar xzf redis-4.0.0.tar.gz
cd redis-4.0.0
make MALLOC=libc -j$(getconf _NPROCESSORS_ONLN) && make install

cp redis.conf /usr/local/etc/
cp /usr/local/etc/redis.conf{,.original}
sed -i 's/daemonize no/daemonize yes/' /usr/local/etc/redis.conf
sed -i 's/timeout 0/timeout 30/' /usr/local/etc/redis.conf
sed -i 's/tcp-keepalive 0/tcp-keepalive 120/' /usr/local/etc/redis.conf
sed -i 's/# maxclients 10000/maxclients 10000/' /usr/local/etc/redis.conf
sed -i 's/# maxmemory-policy noeviction/maxmemory-policy volatile-lru/g' /usr/local/etc/redis.conf

cat >> /etc/sysctl.conf <<EOF
# Set up for Redis
vm.overcommit_memory = 1
EOF

sysctl vm.overcommit_memory=1

wget -q https://raw.githubusercontent.com/oscm/shell/master/database/redis/source/systemd/redis.service -O /usr/lib/systemd/system/redis.service
wget -q https://raw.githubusercontent.com/oscm/shell/master/database/redis/source/systemd/redis-shutdown -O /usr/local/bin/redis-shutdown
chmod 700 /usr/local/bin/redis-shutdown
chown redis:redis /usr/local/bin/redis-shutdown

systemctl enable redis
systemctl start redis

