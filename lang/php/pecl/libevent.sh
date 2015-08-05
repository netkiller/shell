#!/bin/bash
yum install -y libevent-devel
pecl install libevent-beta

cat > /srv/php/etc/conf.d/libevent.ini <<EOF
extension=libevent.so
EOF
