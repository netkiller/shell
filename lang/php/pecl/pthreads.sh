#!/bin/bash

# php-5.6.17
#pecl install pthreads-2.0.10


pecl install pthreads

cat > /srv/php/etc/conf.d/pthreads.ini <<EOF
extension=pthreads.so
EOF
