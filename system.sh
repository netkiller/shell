#!/bin/bash
#================================================================================
# CentOS 6 Installing script by Neo <openunix@163.com>
# http://netkiller.sourceforge.net/ , http://netkiller.github.com/
# $Id$
#================================================================================
SRC_DIR=$(pwd)
PREFIX_DIR=/srv
EMAIL=webmaster@example.com
#================================================================================
BOND_IP=172.16.3.1
BOND_MASK=255.255.255.0
BOND_NETWORK=172.16.3.0
NTPDATE=172.16.3.51
#================================================================================
if [ ! -f /usr/bin/vim ] ; then
	alias vim='vi'
fi

if [ -z "$( egrep "CentOS|Redhat" /etc/issue)" ]; then
	echo 'Only for Redhat or CentOS'
	exit
fi

function ntp(){
	dnf install ntp -y
	ntpdate $NTPDATE

vim /etc/ntp.conf <<VIM > /dev/null 2>&1
:22,24s/^/#/
:25,25s/^/\rserver 172.16.3.51\rserver 172.16.3.52\r/
:wq
VIM

	service ntpd start
	chkconfig ntpd on
}
function snmp (){
	dnf install net-snmp -y

vim /etc/snmp/snmpd.conf <<VIM > /dev/null 2>&1
:62,62s/systemview/all/
:85,85s/^#//
:wq
VIM

	service snmpd start
	chkconfig snmpd on
}

function nagios(){
	dnf install -y nagios
}

function nrpe(){
	dnf install -y nrpe nagios-plugins

vim /etc/nagios/nrpe.cfg <<VIM > /dev/null 2>&1
:%s/allowed_hosts=127.0.0.1/allowed_hosts=172.16.1.2/
:wq
VIM

	cat >> /etc/nagios/nrpe.cfg <<EOF

#command[check_http]=/usr/lib64/nagios/plugins/check_http -I 127.0.0.1 -p 80 -u http://www.example.com/index.html
command[check_swap]=/usr/lib64/nagios/plugins/check_swap -w 20% -c 10%
command[check_all_disks]=/usr/lib64/nagios/plugins/check_disk -w 20% -c 10% -e
EOF

	chkconfig nrpe on
	service nrpe start
}


function init(){
	dnf update -y
	dnf install -y telnet wget rsync
	dnf install -y openssh-clients
	dnf install -y system-config-network-tui
	dnf install -y tcpdump nmap lsof
	dnf remove dhclient -y
	lokkit --disabled --selinux=disabled
	
	rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
	rpm -K http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
	rpm -i http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
}

function limits(){
cat >> /etc/security/limits.conf <<EOF
root 	soft nofile 20480
root 	hard nofile 65536
nobody 	soft nofile 20480
nobody 	hard nofile 65536
EOF

}

function sysctl(){
cat >> /etc/sysctl.conf <<EOF
net.ipv4.ip_local_port_range = 1024 65500
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_intvl = 60
net.ipv4.tcp_keepalive_probes = 3
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_max_tw_buckets = 4096
EOF
/sbin/sysctl -p	
}

function profile(){
    echo >> /etc/profile
    echo "PATH=$PATH:/srv/php/bin:/srv/httpd/bin:/srv/mysql/bin" >> /etc/profile

#vim /etc/profile <<EOF > /dev/null 2>&1
#:31,31s:^:ulimit -SHn 20480 > /dev/null 2>&1\r:
#:wq
#EOF
#:54,88s/^/#/
#:57,57s/^#//
#:65,65s/^#//
#:68,68s/^#//
#:74,75s/^#//
#:80,80s/^#//
#:83,84s/^#//
#:85,87s/^#//
#:58,58s/^#//

}


ssh(){

vim /etc/ssh/sshd_config <<VIM > /dev/null 2>&1
:%s/#PermitRootLogin yes/PermitRootLogin no/
:%s/#AuthorizedKeysFile/AuthorizedKeysFile/
:wq
VIM
/etc/init.d/sshd restart

vim /etc/sudoers <<VIM > /dev/null 2>&1
:86,86s/^# //
:wq!
VIM

vim /etc/group <<VIM > /dev/null 2>&1
:11,11s/$/,neo/
:wq
VIM

}

function bond(){

cat >> /etc/modprobe.d/bonding.conf <<EOF
alias bond0 bonding
options bond0 mode=balance-alb miimon=1000
EOF

cat > /etc/sysconfig/network-scripts/ifcfg-eth0 <<EOF
DEVICE=eth0
ONBOOT=yes
BOOTPROTO=none
USERCTL=no
EOF

cat > /etc/sysconfig/network-scripts/ifcfg-eth1 <<EOF
DEVICE=eth1
ONBOOT=yes
BOOTPROTO=none
USERCTL=no
EOF

cat >> /etc/sysconfig/network-scripts/ifcfg-eth2 <<EOF
DEVICE=eth2
ONBOOT=yes
BOOTPROTO=none
USERCTL=no
EOF

cat >> /etc/sysconfig/network-scripts/ifcfg-eth3 <<EOF
DEVICE=eth3
ONBOOT=yes
BOOTPROTO=none
USERCTL=no
EOF

cat >> /etc/sysconfig/network-scripts/ifcfg-bond0 <<EOF
DEVICE=bond0
ONBOOT=yes
BOOTPROTO=none
TYPE=Ethernet
IPADDR=192.168.80.65
NETMASK=255.255.255.0
NETWORK=192.168.80.0
USERCTL=no
EOF

ifconfig bond0 up
ifenslave bond0 eth0 eth1 eth2 eth3
}

# See how we were called.
case "$1" in
  clean)
        clean
        ;;
  init)
        init
		;;
  limits)
        limits
        ;;
  sysctl)
        sysctl
        ;;		
  profile)
        profile
        ;;		
  ntp)
        ntp
        ;;
  snmp)
        snmp
        ;;
  nagios)
		nagios
		;;		
  nrpe)
        nrpe
        ;;
  ssh)
		ssh
		;;	
  bond)
        if [ ! -f /etc/sysconfig/network-scripts/ifcfg-bond0 ] ; then
                bond
        fi
        ;;			
  all)
        init

        echo ##################################################
        echo # init Installing...
        echo ##################################################
        

        echo ##################################################
        echo # limits and sysctl Installing...
        echo ##################################################
		limits
        sysctl

        echo ##################################################
        echo # ntp,snmp and nrpe Installing...
        echo ##################################################
        ntp
		snmp
		nrpe
        ;;
  bond)
	bond
	;;
  *)
        echo $"Usage: $0 {init}"
        echo "		{limits|sysctl}"
        echo "		{ntp|snmp|nagios|nrpe}"
        RETVAL=2
        ;;
esac

exit $RETVAL
