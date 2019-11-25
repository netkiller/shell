#!/bin/bash
dnf install -y zeromq3-devel
pecl install zmq

cat > /srv/php/etc/conf.d/zmq.ini <<EOF
extension=zmq.so
EOF
