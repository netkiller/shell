#!/bin/bash

yum install -y httpd php
systemctl enable httpd
systemctl start httpd

firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload