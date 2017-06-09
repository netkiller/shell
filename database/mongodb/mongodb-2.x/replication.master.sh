#!/bin/bash

sed -i "s/#master = true/master = true/" /etc/mongod.conf

systemctl restart  mongod
