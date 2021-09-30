dnf -y upgrade
dnf -y install epel-release

dnf install -y bzip2 tree psmisc \
telnet wget rsync vim-enhanced \
net-tools bind-utils

timedatectl set-timezone Asia/Shanghai	
dnf install -y langpacks-en glibc-langpack-en
localectl set-locale LANG=en_US.UTF-8

cat >> /etc/environment <<EOF
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
LC_CTYPE=UTF-8
EOF

cat >> /etc/profile.d/history.sh <<EOF
# Administrator specific aliases and functions for system security
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export TIME_STYLE=long-iso
EOF
source /etc/profile.d/history.sh

cp /etc/selinux/config{,.original}
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
setenforce Permissive

cat >> /etc/sysctl.conf <<EOF

# Netkiller
net.ipv4.ip_local_port_range = 1025 65500
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_keepalive_time = 1800
net.core.netdev_max_backlog=3000
net.ipv4.tcp_max_syn_backlog = 1024
net.ipv4.tcp_max_tw_buckets = 4096
net.core.somaxconn = 1024

# TCP BBR
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF

sysctl -p

cat > /etc/security/limits.d/20-nofile.conf <<EOF

root soft nofile 65535
root hard nofile 65535

www soft nofile 65535
www hard nofile 65535

nginx soft nofile 65535
nginx hard nofile 65535

mysql soft nofile 65535
mysql hard nofile 65535

redis soft nofile 65535
redis hard nofile 65535

rabbitmq soft nofile 40960
rabbitmq hard nofile 40960

hadoop soft nofile 65535
hadoop hard nofile 65535

EOF

