#!/bin/bash

#sestatus
getenforce

cp /etc/selinux/config{,.original}
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config

setenforce Permissive

# You need to restart 
