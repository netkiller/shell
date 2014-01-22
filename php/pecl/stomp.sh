#!/bin/sh
pecl install stomp

cat > /srv/php/etc/conf.d/stomp.ini <<EOF
extension=stomp.so
EOF
