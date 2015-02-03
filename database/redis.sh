#!/bin/bash

sudo apt-get -y install redis-server

cp /etc/redis/redis.conf{,.original}

sysctl vm.overcommit_memory=1

cat >> /etc/sysctl.conf <<EOF
# Set up for Redis
vm.overcommit_memory = 1
EOF
