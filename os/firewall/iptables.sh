#!/bin/bash

systemctl stop firewalld
systemctl disable firewalld

yum remove -y firewalld

yum install iptables-services -y

systemctl start iptables
systemctl enable iptables

systemctl stop ip6tables
systemctl disable ip6tables
