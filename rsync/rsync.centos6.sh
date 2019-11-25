#!/bin/bash
#================================================================================
# CentOS 6 Installing script by Neo <netkiller@msn.com>
# http://netkiller.sourceforge.net/ , http://netkiller.github.io/
# $Id$
#================================================================================

if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
	echo 'Only for Redhat or CentOS'
	exit
fi

dnf install xinetd rsync -y

vim /etc/xinetd.d/rsync <<VIM > /dev/null 2>&1
:%s/yes/no/
:wq
VIM

cat > /etc/rsyncd.conf <<EOD
uid = www
gid = www
use chroot = no
max connections = 8
pid file = /var/run/rsyncd.pid
lock file = /var/run/rsync.lock
log file = /var/log/rsyncd.log

hosts deny=*
hosts allow=192.168.2.0/255.255.255.0

[www]
    uid = www
    gid = www
    path = /www
    ignore errors
    read only = no
    list = no
    auth users = www
    secrets file = /etc/rsyncd.passwd
EOD

cat >> /etc/rsyncd.passwd <<EOF
www:xxxxxxxxxxxxxxxx
EOF

chmod 600 /etc/rsyncd.*
chmod 600 /etc/rsyncd.passwd

service xinetd restart

RETVAL=$?
exit $RETVAL
