Iptables
=====

Sample
----
	[root@localhost ~]# cat  /etc/sysconfig/iptables
	# sample configuration for iptables service
	# you can edit this manually or use system-config-firewall
	# please do not ask us to add additional ports/services to this default configuration
	*filter
	:INPUT ACCEPT [0:0]
	:FORWARD ACCEPT [0:0]
	:OUTPUT ACCEPT [0:0]
	-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
	-A INPUT -p icmp -j ACCEPT
	-A INPUT -i lo -j ACCEPT
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT

	...
	...

	-A INPUT -j REJECT --reject-with icmp-host-prohibited
	-A FORWARD -j REJECT --reject-with icmp-host-prohibited
	COMMIT

SSH
-----
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT

Web
-----
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 8080 -j ACCEPT
	
Samba
-----
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 139 -j ACCEPT
	-A INPUT -p tcp -m state --state NEW -m tcp --dport 445 -j ACCEPT
	-A INPUT -p udp -m udp --dport 137 -j ACCEPT
	-A INPUT -p udp -m udp --dport 138 -j ACCEPT

FTP
-----

	iptables -A INPUT -p tcp --dport 21 -j ACCEPT
	iptables -A INPUT -p tcp --dport 20 -j ACCEPT
			
DNS
-----

	iptables -A INPUT -i eth0 -p tcp --dport 53   -j ACCEPT
	iptables -A INPUT -i eth0 -p udp --dport 53   -j ACCEPT

SOCKS5
-----
	iptables -A INPUT -p tcp --dport 1080 -j ACCEPT

Mail
-----
	# SMTP
	iptables -A INPUT -p tcp --dport 25 -j ACCEPT
	# SMTPS
	iptables -A INPUT -p tcp --dport 465 -j ACCEPT
	# POP3
	iptables -A INPUT -p tcp --dport 110 -j ACCEPT
	# POP3S
	iptables -A INPUT -p tcp --dport 995 -j ACCEPT
	# IMAP
	iptables -A INPUT -p tcp --dport 143 -j ACCEPT
	# IMAPS
	iptables -A INPUT -p tcp --dport 993 -j ACCEPT
			
MySQL
-----

	iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
			
PostgreSQL
-----

	iptables -A INPUT -p tcp --dport 5432 -j ACCEPT

Oracle
-----
	-A INPUT -m state --state NEW -m tcp -p tcp --dport 1521  -j ACCEPT
	
DHCP
-----
	iptables -A INPUT -p UDP -i eth0 --dport 67 -j ACCEPT
	iptables -A INPUT -p UDP -i eth0 --dport 68 -j ACCEPT

VNC
-----	
	-INPUT -m state --state NEW -m tcp -p tcp --dport 5901  -j ACCEPT	