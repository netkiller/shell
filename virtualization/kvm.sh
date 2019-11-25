#!/bin/bash
#================================================================================
# CentOS KVM Installing script by Neo <netkiller@msn.com>
# http://netkiller.sourceforge.net/ , http://netkiller.github.io/
# $Id$
#================================================================================
if [ $(egrep -c '(vmx|svm)' /proc/cpuinfo) == 0 ]; then
	exit
fi
#================================================================================
dnf install -y qemu-kvm libvirt virt-install bridge-utils
systemctl start libvirtd 
systemctl enable libvirtd 
#================================================================================
nmcli c add type bridge autoconnect yes con-name br0 ifname br0 
nmcli c modify br0 ipv4.addresses "192.168.2.5/24 192.168.2.254" ipv4.method manual
nmcli c modify br0 ipv4.dns 8.8.8.8 
nmcli c delete enp2s0
nmcli c add type bridge-slave autoconnect yes con-name enp2s0 ifname enp2s0 master br0
systemctl stop NetworkManager; systemctl start NetworkManager

#echo "net.ipv4.ip_forward = 1"|sudo tee /etc/sysctl.d/99-ipforward.conf
#sysctl -p /etc/sysctl.d/99-ipforward.conf