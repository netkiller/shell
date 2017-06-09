#!/bin/bash

sed -i "s/bind_ip = 127.0.0.1/bind_ip = 0.0.0.0/" /etc/mongod.conf

systemctl restart  mongod
