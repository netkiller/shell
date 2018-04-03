#!/bin/bash

curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | bash

EXTERNAL_URL="http://gitlab.example.com"
yum install -y gitlab-ce

gitlab-ctl reconfigure

cp /etc/gitlab/gitlab.rb{,.original}

cat <<EOF
# Username: root 
# Password: 5iveL!fe
EOF
