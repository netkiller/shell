#!/bin/bash

#if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
#        echo 'Only for Redhat or CentOS'
#        exit
#fi

if [ -f /usr/bin/yum ]; then
        yum install git -y
fi
