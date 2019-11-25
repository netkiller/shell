#!/bin/bash
##################################################
# Redis 5.0.0 setup script
# Author: netkiller<netkiller@msn.com>
# Website: http://www.netkiller.cn
##################################################
cd /usr/local/src

# dnf install -y jemalloc-devel

if [ ! -f /usr/bin/gcc ]; then
	curl -s https://raw.githubusercontent.com/oscm/shell/master/lang/gcc/gcc.sh | bash
fi

id redis
if [ $? -eq 1 ] 
then
	adduser -s /bin/false -d /var/lib/redis redis
fi

if [ ! -f redis-5.0.5.tar.gz ]; then
	wget http://download.redis.io/releases/redis-5.0.5.tar.gz	
fi

tar xzf redis-5.0.5.tar.gz
cd redis-5.0.5
# make && make install
make -j$(getconf _NPROCESSORS_ONLN) && make install

cp redis.conf /usr/local/etc/
cp /usr/local/etc/redis.conf{,.original}
sed -i 's/daemonize no/daemonize yes/' /usr/local/etc/redis.conf
# sed -i 's/timeout 0/timeout 30/' /usr/local/etc/redis.conf
# sed -i 's/tcp-keepalive 0/tcp-keepalive 120/' /usr/local/etc/redis.conf
sed -i 's/# maxclients 10000/maxclients 10000/' /usr/local/etc/redis.conf
sed -i 's/# maxmemory-policy noeviction/maxmemory-policy volatile-lru/g' /usr/local/etc/redis.conf
sed -i 's#^dir ./#dir /var/lib/redis#' /usr/local/etc/redis.conf

mkdir -p /var/lib/redis
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

wget -q https://raw.githubusercontent.com/oscm/shell/master/database/redis/source/systemd/redis.service -O /usr/lib/systemd/system/redis.service
wget -q https://raw.githubusercontent.com/oscm/shell/master/database/redis/source/systemd/redis-shutdown -O /usr/local/bin/redis-shutdown
chmod 700 /usr/local/bin/redis-shutdown
chown redis:redis /usr/local/bin/redis-shutdown

systemctl enable redis
systemctl start redis
systemctl status redis