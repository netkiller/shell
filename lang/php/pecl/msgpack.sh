#!/bin/bash

#pecl install msgpack
pecl install  channel://pecl.php.net/msgpack-0.5.5  

cat > /srv/php/etc/conf.d/msgpack.ini <<EOF
extension=msgpack.so
EOF
