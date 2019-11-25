#!/bin/bash

dnf install ntp -y

#vim /etc/ntp.conf <<VIM > /dev/null 2>&1
#:22,24s/^/#/
#:25,25s/^/\rserver 172.16.3.51\rserver 172.16.3.52\r/
#:wq
#VIM
systemctl enable ntpd
systemctl start ntpd