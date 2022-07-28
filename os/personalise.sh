#!/bin/bash
curl -s https://raw.githubusercontent.com/netkiller/shell/master/os/epel-release.sh | bash
curl -s https://raw.githubusercontent.com/netkiller/shell/master/os/etc/etc.sh | bash
#curl -s https://raw.githubusercontent.com/netkiller/shell/master/os/firewall/iptables.sh | bash
#curl -s https://raw.githubusercontent.com/netkiller/shell/master/os/ntpd/ntpdate.sh | bash
curl -s https://raw.githubusercontent.com/netkiller/shell/master/os/chrony.sh
curl -s https://raw.githubusercontent.com/netkiller/shell/master/os/etc/ssh/ssh.sh | bash
curl -s https://raw.githubusercontent.com/netkiller/shell/master/os/zmodem.sh | bash
