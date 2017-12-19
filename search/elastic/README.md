Elastic
=====

CentOS Init
-----

	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/epel-release.sh | bash
    curl -s https://raw.githubusercontent.com/oscm/shell/master/os/etc.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/selinux.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/iptables/iptables.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/ntpd/ntp.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/ssh/sshd_config.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/zmodem.sh | bash

To add the Elastic repository for YUM
-----

	curl -s https://raw.githubusercontent.com/oscm/shell/master/search/elastic/elastic-6.x.sh | bash

Manual Install 
-----

	yum install elasticsearch
	yum install logstash
	yum install kibana
	yum install filebeta
	
OSCM Install
-----

	curl -s https://raw.githubusercontent.com/oscm/shell/master/search/elastic/beats/beats.sh | bash


Donations
---------
We accept PayPal through:

https://www.paypal.me/netkiller

Wechat (微信) / Alipay (支付宝) 打赏:

http://www.netkiller.cn/home/donations.html

