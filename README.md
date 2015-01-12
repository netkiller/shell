linux shell
=====
This is a group of installation script, it can achieve fast initialization of your server.

Install
-----
	git clone https://github.com/oscm/shell.git
	
Update
-----
	git pull

CentOS Init
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/ssh/sshd_config.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/ntpd/ntp.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/centos.sh | bash

Nginx
-----

    curl -s https://raw.githubusercontent.com/oscm/shell/master/centos6.sh | bash
    curl -s https://raw.githubusercontent.com/oscm/shell/master/modules/ntp.sh | bash
    curl -s https://raw.githubusercontent.com/oscm/shell/master/filesystem/btrfs.sh | bash
    curl -s https://raw.githubusercontent.com/oscm/shell/master/nginx/nginx.sh | bash
    curl -s https://raw.githubusercontent.com/oscm/shell/master/php/5.4.x.sh | bash
    curl -s https://raw.githubusercontent.com/oscm/shell/master/php/redis.sh | bash

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
