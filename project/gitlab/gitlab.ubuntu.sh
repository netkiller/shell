#!/bin/bash

sudo apt-get install curl openssh-server ca-certificates postfix
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo apt-get install gitlab-ce

sudo gitlab-ctl reconfigure

cp /etc/gitlab/gitlab.rb{,.original}

# Username: root 
# Password: 5iveL!fe