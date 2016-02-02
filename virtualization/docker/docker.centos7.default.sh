#!/bin/bash

if [ -z "$( egrep "CentOS|Redhat" /etc/centos-release)" ]; then
        echo 'Only for Redhat or CentOS'
        exit
fi

#yum update -y
yum install -y docker
systemctl start docker
docker pull centos
docker images centos