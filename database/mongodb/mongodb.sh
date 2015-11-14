#!/bin/bash

yum install mongodb-server mongodb -y

systemctl enable mongod.service
systemctl start mongod 

cp /etc/mongod.conf{,.original}
cp /etc/mongos.conf{,.original}

systemctl restart  mongod

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 27017 -j ACCEPT
systemctl save iptables 
