#!/bin/sh
dnf localinstall -y http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
dnf install mysql-community-devel -y
