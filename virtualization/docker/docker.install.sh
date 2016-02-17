#!/bin/bash

if [ -z "$( egrep "CentOS|Redhat" /etc/centos-release)" ]; then
        echo 'Only for Redhat or CentOS'
        exit
fi

sudo yum install -y docker-engine

systemctl enable docker
systemctl start docker