#!/bin/bash

if [ "$( hostname )" == "www.mydomain.com" ]; then
		curl -q -s https://raw.github.com/netkiller/shell/master/centos6.sh | bash
		curl -q -s https://raw.github.com/netkiller/shell/master/modules/nginx.sh | bash
        echo '====================================================================='
fi

if [ "$( hostname )" == "db.mydomain.com" ]; then
		curl -q -s https://raw.github.com/netkiller/shell/master/centos6.sh | bash
		curl -q -s https://raw.github.com/netkiller/shell/master/modules/mysql.sh | bash
        echo '====================================================================='
fi