#!/bin/sh
##########################################
# Author netkiller<netkiller@msn.com>
# http://www.netkiller.cn
##########################################
# iptables -t nat -I POSTROUTING -m state --state NEW -p tcp --dport 25 -o eth0 -m statistic --mode nth --every 5 -j SNAT --to-source 1.1.1.1
# iptables -t nat -I POSTROUTING -m state --state NEW -p tcp --dport 25 -o enp2s0 -m statistic --mode nth --every 5 --packet 0 -j SNAT --to-source
# -A POSTROUTING -o em2 -p tcp -m state --state NEW -m tcp --dport 80 -m statistic --mode nth --every 2 --packet 0 -j SNAT --to-source 107.167.40.130
##########################################

eth=$1
dport=$2
every=$3
prefix=$4
from=$5
to=$6

if [ -z $1 ]; then
	echo "Usage: rotate.ipaddr.sh <eth> <port> <every> <ipaddr-prefix> <ip-from> <ip-to>"
	echo "Example: rotate.ipaddr.sh enp2s0 25 60 192.168.0 10 250"
	exit
fi

for ip in $(seq $from $to)
do 
	echo "iptables -t nat -I POSTROUTING -o $eth -p tcp -m state --state NEW -m tcp --dport $dport -m statistic --mode nth --every $every --packet 0 -j SNAT --to-source $prefix.$ip"
done
