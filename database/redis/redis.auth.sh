#!/bin/bash

random=$(cat /dev/urandom | tr -cd [:alnum:] | fold -w32 | head -n 1)
sed -i "s/# requirepass foobared/requirepass ${random}/g" /etc/redis.conf 
echo "Redis random password is: ${random}"
systemctl restart redis
#sed -i 's/# requirepass foobared/requirepass passw0rd/g' /etc/redis.conf 

