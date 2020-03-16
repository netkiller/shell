#!/bin/bash

if [ -z "$( egrep "CentOS|Redhat" /etc/centos-release)" ]; then
        echo 'Only for Redhat or CentOS'
        exit
fi

dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

dnf install -y docker-ce

systemctl enable docker
systemctl start docker

# usermod -aG docker $USER