#!/bin/bash

if [ -z "$( egrep "CentOS Linux release|8.0" /etc/redhat-release)" ]; then
	echo 'Only for Redhat or CentOS'
	exit
fi

dnf install -y gcc gcc-c++ make cmake automake autoconf patch
