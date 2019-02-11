#!/bin/bash

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

yum install -y jenkins

systemctl enable jenkins.service
systemctl start jenkins.service

# /etc/sysconfig/jenkins

cat /var/lib/jenkins/secrets/initialAdminPassword
