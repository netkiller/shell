dnf -y upgrade
dnf -y install epel-release

cat >> /etc/profile.d/history.sh <<EOF
# Administrator specific aliases and functions for system security
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export TIME_STYLE=long-iso
EOF

source /etc/profile.d/history.sh

cat >> /etc/sysctl.conf <<EOF

# add by netkiller
net.ipv4.ip_local_port_range = 1025 65500
net.core.somaxconn = 1024

# TCP BBR
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF

sysctl -p