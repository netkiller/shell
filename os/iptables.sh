#!/bin/bash

yum install iptables-services -y

systemctl stop firewalld
systemctl disable firewalld

systemctl start iptables
systemctl enable iptables

# systemctl start ip6tables
systemctl disable ip6table
