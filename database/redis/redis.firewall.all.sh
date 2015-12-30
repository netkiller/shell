#!/bin/bash

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 6379 -j ACCEPT
service iptables save

