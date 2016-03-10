#!/bin/bash

function check_extension(){
	local extension=$1
	local found=$(php -m | grep $extension)
	if [ -z $found  ] ; then
		echo "[False] ${extension}"
	else 
		echo "[OK] ${extension}"
	fi
}

check_extension redis
check_extension phalcon
check_extension pthreads
check_extension mongo
check_extension memcache
