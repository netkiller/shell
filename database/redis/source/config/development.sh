#!/bin/bash

sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /usr/local/etc/redis.conf

systemctl restart redis