#!/bin/bash

sed -i "s/#security:/security:/" /etc/mongod.conf
sed -i "33 i \ \ authorization: enabled" /etc/mongod.conf

systemctl restart  mongod
