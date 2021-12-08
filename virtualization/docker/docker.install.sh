#!/bin/bash
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce

systemctl enable docker
systemctl start docker

# usermod -aG docker $USER
adduser -u 992 -g 992 docker
#usermod -aG docker docker && newgrp docker