#!/bin/bash

sudo tee /etc/dnf.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://dnf.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://dnf.dockerproject.org/gpg
EOF
