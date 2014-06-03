#!/bin/bash

pecl install pthreads

cat > /srv/php/etc/conf.d/pthreads.ini <<EOF
extension=pthreads.so
EOF
