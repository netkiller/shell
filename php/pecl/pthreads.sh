#!/bin/bash

pecl install pthread

cat > /srv/php/etc/conf.d/pthreads.ini <<EOF
extension=pthreads.so
EOF