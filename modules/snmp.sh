#!/bin/bash

if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
        echo 'Only for Redhat or CentOS'
        exit
fi

yum install net-snmp -y
vi /etc/snmp/snmpd.conf <<VIM > /dev/null 2>&1
:62,62s/systemview/all/
:85,85s/^#//
:wq
VIM
service snmpd start
chkconfig snmpd on