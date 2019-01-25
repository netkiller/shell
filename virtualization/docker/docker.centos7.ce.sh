#!/bin/bash

yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum makecache fast

yum -y install docker-ce
yum list docker-ce

systemctl enable docker
systemctl start docker