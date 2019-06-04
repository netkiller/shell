iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5432 -j ACCEPT
systemctl save iptables