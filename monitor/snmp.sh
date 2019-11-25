#!/bin/bash

dnf install net-snmp -y

cp /etc/snmp/snmpd.conf{,.original}
vim /etc/snmp/snmpd.conf <<VIM > /dev/null 2>&1
:47,47s/^/#/
:62,62s/systemview/all/
:85,85s/^#//
:162,162s/syslocation Unknown/syslocation Neo/
:163,163s/syscontact Root <root@localhost>/syscontact Neo <netkiller@msn.com>/
:wq
VIM

systemctl enable snmpd
systemctl start snmpd