#!/bin/sh
yum install -y librabbitmq-devel
pecl install amqp

cat > /srv/php/etc/conf.d/amqp.ini <<EOF
extension=amqp.so
EOF
