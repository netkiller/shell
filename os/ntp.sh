#!/bin/bash

if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
        echo 'Only for Redhat or CentOS'
        exit
fi

yum install ntp -y

#vim /etc/ntp.conf <<VIM > /dev/null 2>&1
#:22,24s/^/#/
#:25,25s/^/\rserver 172.16.3.51\rserver 172.16.3.52\r/
#:wq
#VIM

service ntpd start
chkconfig ntpd on
