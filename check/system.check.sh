#!/bin/bash

function check_file(){
	local filename=$1
	local include=$2
	if [ ! -f $filename	] ; then
		echo "[False] ${filename}"
	else 
		echo "[OK] ${filename}"
	fi
}

function check_process(){
	local proc=$1
	if [ -z "$( pgrep ${proc} )" ]; then
		echo "[False] ${proc}"
	else
		echo "[OK] ${proc}"
	fi
}

function section(){
	local title=$1
	echo "=================================================="
	echo " $title "
	echo "=================================================="
}

section "Operation System"
check_process sshd
check_process ntpd
check_process xinetd
check_process crond

section "Web Application"
check_process httpd
check_process nginx
check_process php-cgi
check_process php-fpm

section "Database Application"
check_process mongod
check_process redis-server
check_process postgres
check_process postmaster
check_process mysqld
check_process mysqld_safe

section "Operation System files"
check_file /etc/resolv.conf
check_file /etc/security/limits.conf
check_file /etc/sysctl.conf

exit
