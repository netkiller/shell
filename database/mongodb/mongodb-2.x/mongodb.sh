#!/bin/bash

yum install mongodb-server mongodb -y

systemctl enable mongod.service
systemctl start mongod 

cp /etc/mongod.conf{,.original}
cp /etc/mongos.conf{,.original}

systemctl restart  mongod
