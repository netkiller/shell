#!/bin/bash

# php-5.6.31 is ok
pecl install pthreads-2.0.10

cat > /srv/php/etc/conf.d/pthreads.ini <<EOF
extension=pthreads.so
EOF
