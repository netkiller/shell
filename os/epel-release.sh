#!/bin/bash

cp /etc/dnf/dnf.conf{,.original}		
echo "fastestmirror=True" >> /etc/dnf/dnf.conf
dnf makecache

dnf -y install epel-release
dnf -y update

dnf install -y bzip2 tree psmisc \
telnet wget rsync vim-enhanced \
net-tools bind-utils