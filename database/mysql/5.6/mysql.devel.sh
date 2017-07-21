#!/bin/sh
yum localinstall -y http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
yum install mysql-community-devel -y
