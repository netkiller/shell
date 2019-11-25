#!/bin/bash

if [ -z "$( egrep "CentOS|Redhat" /etc/centos-release)" ]; then
        echo 'Only for Redhat or CentOS'
        exit
fi

#dnf update -y
dnf install -y docker
systemctl enable docker
systemctl start docker
docker pull centos
docker images centos