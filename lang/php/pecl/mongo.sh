#!/bin/sh
pecl install mongo

cat > /srv/php/etc/conf.d/mongo.ini <<EOF
extension=mongo.so
EOF
