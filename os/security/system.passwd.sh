#!/bin/bash

function section(){
	local title=$1
	echo "=================================================="
	echo " $title "
	echo "=================================================="
}

section "Check login user"
grep -v nologin /etc/passwd

section "Check login password"
grep '\$' /etc/shadow

section "Check SSH authorized_keys file"
for key in $(ls -1 /home) 
do 
	if [ -e $key/.ssh/authorized_keys ]; then 
		echo "$key : $key/.ssh/authorized_keys"
	else
		echo "$key : "
	fi
done