#!/bin/bash
yum -y install epel-release

#yum localinstall -y http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
#http://ftp.cuhk.edu.hk/pub/linux/fedora-epel/7/x86_64/e/epel-release-7-5.noarch.rpm
#yum install -y openssh-clients

yum remove -y dhclient dhcp-*
yum install -y telnet wget rsync vim-enhanced
yum install -y net-tools bind-utils

yum update -y