#!/bin/bash

systemctl stop firewalld
systemctl disable firewalld

dnf remove -y firewalld

dnf install iptables-services -y

systemctl start iptables
systemctl enable iptables

systemctl stop ip6tables
systemctl disable ip6tables
