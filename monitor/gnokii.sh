#!/bin/bash

yum install -y gnokii	

chmod +x  /usr/bin/sendsms

cp /etc/gnokiirc{,.original}

vim /etc/gnokiirc <<VIM > /dev/null 2>&1
:%s:port = none:port = /dev/ttyS0:
:54,54s/model = fake/model = AT/
:wq
VIM
service snmpd start
chkconfig snmpd on