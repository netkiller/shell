#!/bin/sh
yum install -y librabbitmq-devel
pecl install amqp

cat > /srv/php/etc/conf.d/stomp.ini <<EOF
extension=stomp.so
EOF
