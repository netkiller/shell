Postfix Install
===============

Centos Init
-----------
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/centos7.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/selinux.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/iptables/iptables.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/ntpd/ntp.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/ssh/sshd_config.sh | bash

Install Postfix
---------------
  curl -s https://raw.githubusercontent.com/oscm/shell/master/mail/postfix/postfix.sh | bash
