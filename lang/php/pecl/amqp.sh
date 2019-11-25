#!/bin/bash
dnf install -y librabbitmq-devel
pecl install amqp

cat > /srv/php/etc/conf.d/amqp.ini <<EOF
extension=amqp.so
EOF
