#!/bin/sh

yum install -y http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.7/rabbitmq-server-3.6.7-1.el7.noarch.rpm

systemctl enable rabbitmq-server
systemctl start rabbitmq-server