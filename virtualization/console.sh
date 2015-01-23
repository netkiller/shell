#!/bin/bash
#================================================================================
# CentOS KVM Installing script by Neo <netkiller@msn.com>
# http://netkiller.sourceforge.net/ , http://netkiller.github.io/
# $Id$
#================================================================================

#================================================================================

#================================================================================

if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
	echo 'Only for Redhat or CentOS'
	exit
fi

echo "ttyS0" >> /etc/securetty

echo "S0:2345:respawn:/sbin/agetty ttyS0 115200" >> /etc/inittab

#echo "co:2345:respawn:/sbin/mingetty ttyS0 115200 vt100" >> /etc/inittab
