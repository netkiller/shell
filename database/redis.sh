#!/bin/bash

if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
        echo 'Only for Redhat or CentOS'
        exit
fi

rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-7.noarch.rpm

yum install redis -y

chkconfig redis on
service redis start

cp /etc/redis.conf{,.original}