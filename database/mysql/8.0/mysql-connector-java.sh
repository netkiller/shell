#!/bin/sh

if [ -z $(rpm -qa mysql80-community-release) ]; then

    curl -s https://raw.githubusercontent.com/netkiller/shell/master/database/mysql/8.0/mysql80-community-release.sh | bash

fi

dnf install -y mysql-connector-java
ls /usr/share/java/mysql-connector-java.jar
