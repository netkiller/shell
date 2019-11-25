#!/bin/sh

dnf install -y https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.15/rabbitmq-server-3.7.15-1.el7.noarch.rpm

systemctl enable rabbitmq-server
systemctl start rabbitmq-server