# Redis 

## GCC

    curl -s https://raw.githubusercontent.com/oscm/shell/master/lang/gcc/gcc.sh | bash

## Setup 

    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/redis/source/redis-4.0.0.sh | bash

## Redis 4.0.6
    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/redis/source/redis-4.0.6.sh | bash

## Systemd

    wget -q https://raw.githubusercontent.com/oscm/shell/master/database/redis/source/systemd/redis.service -O /usr/lib/systemd/system/redis.service
    wget -q https://raw.githubusercontent.com/oscm/shell/master/database/redis/source/systemd/redis-shutdown -O /usr/local/bin/redis-shutdown

    systemctl enable redis
    systemctl start redis

## Devel Library
