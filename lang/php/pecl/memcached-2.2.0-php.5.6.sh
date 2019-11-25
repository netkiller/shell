#!/bin/sh

dnf install libmemcached-devel
pecl install memcached

cat > /srv/php/etc/conf.d/memcached.ini <<EOF
extension=memcached.so
EOF

