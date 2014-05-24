#!/bin/bash

pecl install xdebug

cat > /srv/php/etc/conf.d/xdebug.ini <<EOF
[Zend Modules]
zend_extension=xdebug.so
;zend_extension_ts=xdebug.so

[Xdebug]
xdebug.profiler_enable = on
xdebug.trace_output_dir = "/var/tmp/xdebug"
xdebug.profiler_output_dir = "/var/tmp/xdebug"
EOF
