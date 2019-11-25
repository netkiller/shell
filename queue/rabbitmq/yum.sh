#!/bin/sh

dnf install -y rabbitmq-server

systemctl enable rabbitmq-server
systemctl start rabbitmq-server