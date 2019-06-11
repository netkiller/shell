#!/bin/bash
#================================================================================
# CentOS 7 Installing script by Neo <netkiller@msn.com>
# http://netkiller.sourceforge.net/, http://netkiller.github.io/
# $Id$
#================================================================================
if [ ! -f /usr/bin/vim ] ; then
	alias vim='vi'
fi

#if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
#	echo 'Only for Redhat or CentOS'
#	exit
#fi

#vim /etc/ssh/sshd_config <<VIM > /dev/null 2>&1
#:s/#PermitRootLogin yes/PermitRootLogin no/
#:wq
#VIM

passwd -l bin
passwd -l daemon
passwd -l adm
passwd -l lp
passwd -l sync
passwd -l shutdown
passwd -l halt
passwd -l mail
passwd -l operator
passwd -l games
passwd -l ftp
passwd -l nobody
passwd -l systemd-network
passwd -l dbus
passwd -l polkitd
passwd -l chrony
passwd -l ntp
passwd -l postfix

# chattr /etc/passwd /etc/shadow
chattr +i /etc/passwd
chattr +i /etc/group
chattr +i /etc/shadow*
chattr +i /etc/gshadow*

# history security
chattr +a /root/.bash_history
chattr +i /root/.bash_history

#echo "system timeout 5 minite auto logout" >>/etc/profile
#echo "TMOUT=300" >>/etc/profile

RETVAL=0
exit $RETVAL
