#!/bin/bash

systemctl list-unit-files | grep iptables

iptables -t nat -A PREROUTING -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 8080

/usr/libexec/iptables/iptables.init save