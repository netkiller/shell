#!/bin/bash

dnf install -y dnf-utils
dnf-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

dnf makecache fast

dnf -y install docker-ce
dnf list docker-ce

systemctl enable docker
systemctl start docker