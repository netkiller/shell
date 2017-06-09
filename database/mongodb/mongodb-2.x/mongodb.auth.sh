#!/bin/bash

sed -i "s/#auth = true/auth = true/" /etc/mongod.conf

systemctl restart  mongod
