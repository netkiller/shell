#!/bin/bash
curl -s https://raw.githubusercontent.com/oscm/shell/master/os/epel-release.sh | bash
curl -s https://raw.githubusercontent.com/oscm/shell/master/os/etc/etc.sh | bash
#curl -s https://raw.githubusercontent.com/oscm/shell/master/os/firewall/iptables.sh | bash
curl -s https://raw.githubusercontent.com/oscm/shell/master/os/ntpd/ntpdate.sh | bash
curl -s https://raw.githubusercontent.com/oscm/shell/master/os/ssh/ssh.sh | bash
curl -s https://raw.githubusercontent.com/oscm/shell/master/os/zmodem.sh | bash
