cat >> /etc/sysctl.conf <<EOF

# Netkiller OSCM
net.ipv4.ip_local_port_range = 1025 65500
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_keepalive_time = 1800
net.core.netdev_max_backlog=3000
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 4096
net.core.somaxconn = 1024

# TCP BBR
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF

#net.ipv4.tcp_tw_recycle = 1 CentOS 8 不支持
#net.ipv4.tcp_syncookies = 1
#net.ipv4.tcp_fin_timeout = 60

sysctl -p
