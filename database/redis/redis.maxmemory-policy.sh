#!/bin/bash

sed -i 's/# maxmemory-policy noeviction/maxmemory-policy volatile-lru/g' /etc/redis.conf

