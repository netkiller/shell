#!/bin/bash

dnf install libgearman-devel -y
pecl install gearman

cat >> /srv/php/etc/conf.d/gearman.ini <<EOF
extension=gearman.so
EOF