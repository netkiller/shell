#!/bin/sh

pecl install memcache

cat >> /srv/php/etc/php.ini <<EOF
extension = memcache.so
[memcache]
memcache.allow_failover = 1
memcache.max_failover_attempts=20
memcache.chunk_size =8192
memcache.default_port = 11211
memcache.default_timeout_ms=30
EOF
