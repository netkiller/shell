#!/bin/sh

yum install rabbitmq-server

systemctl enable rabbitmq-server
systemctl start rabbitmq-server