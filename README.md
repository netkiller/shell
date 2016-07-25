linux shell
=====

[![Join the chat at https://gitter.im/oscm/shell](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/oscm/shell?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This is a group of installation script, it can achieve fast initialization of your server.

Install
-----
	git clone https://github.com/oscm/shell.git
	
Update
-----
	git pull

CentOS Init
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/centos7.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/epel-release.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/selinux.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/iptables/iptables.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/ntpd/ntp.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/ssh/sshd_config.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/zmodem.sh | bash

Automatic installation Nginx web server
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/node.nginx.sh | bash

Apache httpd
------------

    curl -s https://raw.githubusercontent.com/oscm/shell/master/centos6.sh | bash
    curl -s https://raw.githubusercontent.com/oscm/shell/master/modules/ntp.sh | bash
    curl -s https://raw.githubusercontent.com/oscm/shell/master/filesystem/btrfs.sh | bash
    curl -s https://raw.githubusercontent.com/oscm/shell/master/apache/httpd-2.4.4.sh | bash
    curl -s https://raw.githubusercontent.com/oscm/shell/master/php/httpd.5.3.x.sh | bash 

Database
--------

    # curl -s https://raw.githubusercontent.com/oscm/shell/master/modules/mongodb.sh | bash 
    # curl -s https://raw.githubusercontent.com/oscm/shell/master/modules/redis.sh | bash
    # curl -s https://raw.githubusercontent.com/oscm/shell/master/database/postgresql.sh | bash
    
Node Install
------------

    if [ "$( hostname )" == "www.mydomain.com" ]; then
		curl -q -s https://raw.githubusercontent.com/oscm/shell/master/centos6.sh | bash
		curl -q -s https://raw.githubusercontent.com/oscm/shell/master/modules/nginx.sh | bash
        echo '====================================================================='
    fi

    if [ "$( hostname )" == "db.mydomain.com" ]; then
		curl -q -s https://raw.githubusercontent.com/oscm/shell/master/centos6.sh | bash
		curl -q -s https://raw.githubusercontent.com/oscm/shell/master/modules/mysql.sh | bash
        echo '====================================================================='
    fi

Donations
---------
We accept tips through [Gittip][tip].

[![Gittip](http://img.shields.io/gittip/Homebrew.svg)](https://www.gittip.com/netkiller/)


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/oscm/shell/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

