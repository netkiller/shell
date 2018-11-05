#!/bin/bash

sed -i "33s/#security:/security:/" /etc/mongod.conf
sed -i "34 i \ \ authorization: enabled" /etc/mongod.conf

systemctl restart  mongod
