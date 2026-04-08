#!/bin/bash
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-compose-plugin

systemctl enable docker
systemctl start docker

dnf list installed | grep docker

GID=$(egrep -o 'docker:x:([0-9]+)' /etc/group | egrep -o '([0-9]+)')
adduser --system -u ${GID} -g ${GID} -G wheel -c "Container Administrator" docker

#adduser -u 992 -g 992 docker
#usermod -aG docker docker && newgrp docker

cat > /etc/sudoers.d/docker <<-EOF
docker    ALL=(ALL)    NOPASSWD: ALL
EOF