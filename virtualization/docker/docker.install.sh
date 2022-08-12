#!/bin/bash
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-compose-plugin

systemctl enable docker
systemctl start docker

GID=$(egrep -o 'docker:x:([0-9]+)' /etc/group | egrep -o '([0-9]+)')
adduser -u ${GID} -g ${GID} docker

#adduser -u 992 -g 992 docker
#usermod -aG docker docker && newgrp docker