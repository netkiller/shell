#!/bin/bash
########################################
# Author: Neo <netiller@msn.com>
# Home : http://netkiler.github.io
# Project: https://github.com/netkiller/shell
########################################
domain=$1
########################################
function include(){
	txt=$1
	for host in $(echo $txt | egrep -o "include:(.+) ")
	do
		txt=$(dig $(echo $host | cut -d":" -f2) txt | grep "v=spf1")
		echo $txt;
		if [ "$(echo $txt | grep "include")" ]; then
			include "$txt"
		fi
	done
}
function main(){
	spf=$(dig ${domain} txt | grep "v=spf1")
	echo $spf

	if [ "$(echo $spf | grep "include")" ]; then
		include "$spf"
	fi
}

main $domain