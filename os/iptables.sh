#!/bin/bash

systemctl stop firewalld
systemctl disable firewalld

systemctl start iptables
systemctl enable iptables

# systemctl start ip6tables
systemctl disable ip6table