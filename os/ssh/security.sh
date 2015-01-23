#!/bin/bash
#================================================================================
# CentOS 6 Installing script by Neo <netkiller@msn.com>
# http://netkiller.sourceforge.net/ , http://netkiller.github.io/
# $Id$
#================================================================================

#================================================================================

#================================================================================
if [ ! -f /usr/bin/vim ] ; then
	alias vim='vi'
fi

if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
	echo 'Only for Redhat or CentOS'
	exit
fi

echo ##################################################
echo # optimizer sshd_config ...
echo ##################################################

vim /etc/ssh/sshd_config <<VIM > /dev/null 2>&1
:s/#LoginGraceTime 2m/LoginGraceTime 2m/
:s/#PermitRootLogin yes/PermitRootLogin no/
:s/#MaxAuthTries 6/MaxAuthTries 3/
:%s/#AuthorizedKeysFile/AuthorizedKeysFile/
:%s/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/
:%s/GSSAPIAuthentication yes/GSSAPIAuthentication no/
:%s/GSSAPICleanupCredentials yes/GSSAPICleanupCredentials no/
:wq
VIM

sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config

/etc/init.d/sshd restart

echo ##################################################
echo # config sudoers ...
echo ##################################################
vim /etc/sudoers <<VIM > /dev/null 2>&1
:86,86s/^# //
:wq!
VIM

echo ##################################################
echo # lock user  ...
echo ##################################################

passwd -l bin
passwd -l daemon
passwd -l adm
passwd -l lp
passwd -l sync
passwd -l shutdown
passwd -l halt
passwd -l mail
passwd -l uucp
passwd -l operator
passwd -l games
passwd -l gopher
passwd -l ftp
passwd -l nobody
passwd -l vcsa
passwd -l saslauth
passwd -l postfix

# chattr /etc/passwd /etc/shadow
chattr +i /etc/passwd
chattr +i /etc/group
chattr +i /etc/shadow*
chattr +i /etc/gshadow*

# history security
chattr +a /root/.bash_history
chattr +i /root/.bash_history

# system timeout 5 minite auto logout
echo "TMOUT=300" >>/etc/profile




RETVAL=0
exit $RETVAL
