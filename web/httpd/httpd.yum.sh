#!/bin/bash

yum install -y httpd php
systemctl enable httpd
systemctl start httpd

cp /etc/php.ini{,.original}

firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
