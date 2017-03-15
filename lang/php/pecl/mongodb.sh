#!/bin/sh
pecl install mongodb

cat > /srv/php/etc/conf.d/mongodb.ini <<EOF
extension=mongodb.so
EOF
