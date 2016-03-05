#!/bin/bash

yum localinstall -y https://downloads-packages.s3.amazonaws.com/centos-7.0.1406/gitlab-7.9.1_omnibus.1-1.el7.x86_64.rpm

# yum update https://downloads-packages.s3.amazonaws.com/centos-7.1.1503/gitlab-ce-7.10.0~omnibus-1.x86_64.rpm

gitlab-ctl reconfigure

cp /etc/gitlab/gitlab.rb{,.original}

# Username: root 
# Password: 5iveL!fe