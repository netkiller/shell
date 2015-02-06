Nagios
=====
This is a group of installation script, it can achieve fast initialization of your server.

Install Nagios Core
-----
	https://raw.githubusercontent.com/oscm/shell/master/monitor/nagios/nagios.sh
	
Install Nrpe
-----
	# Centos6 
	rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
	# Centos7
	yum localinstall -y http://ftp.cuhk.edu.hk/pub/linux/fedora-epel/7/x86_64/e/epel-release-7-5.noarch.rpm
	
	yum update -y

	https://raw.githubusercontent.com/oscm/shell/master/monitor/nagios/nrpe.sh

Donations
---------
We accept tips through [Gittip][tip].

[![Gittip](http://img.shields.io/gittip/Homebrew.svg)](https://www.gittip.com/netkiller/)
