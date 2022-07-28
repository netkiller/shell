#!/bin/sh

if [ -z $(rpm -qa mysql57-community-release) ]; then
    curl -s https://raw.githubusercontent.com/netkiller/shell/master/database/mysql/5.7/mysql57-community-release-el7-7.sh | bash
fi

dnf install -y mysql-connector-java
ls /usr/share/java/mysql-connector-java.jar


