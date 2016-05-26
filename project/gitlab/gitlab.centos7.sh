#!/bin/bash

curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | bash
yum install -y gitlab-ce

gitlab-ctl reconfigure

cp /etc/gitlab/gitlab.rb{,.original}

# Username: root 
# Password: 5iveL!fe