#!/bin/sh

if [ -z $(rpm -qa mysql57-community-release) ]; then
    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mysql/5.7/mysql57-community-release-el7-7.sh | bash
fi

yum install -y mysql-connector-java
ls /usr/share/java/mysql-connector-java.jar


