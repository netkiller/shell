#!/bin/bash

sed -i "s/#slave = true/slave = true/" /etc/mongod.conf
sed -i "s/#source = arg/source = mongodb.master.example.com/" /etc/mongod.conf

systemctl restart  mongod
