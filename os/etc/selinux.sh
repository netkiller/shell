#!/bin/bash

#sestatus
getenforce

cp /etc/selinux/config{,.original}
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config

# You need to restart 