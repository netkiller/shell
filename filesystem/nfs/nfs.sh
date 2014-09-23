yum install -y nfs-utils

cat >> /etc/exports <<EOF
/www 		192.168.6.0/24(rw,sync,fsid=0,anonuid=80,anongid=80)
EOF

chkconfig rpcbind on
chkconfig nfs on
chkconfig nfslock on
chkconfig rpcidmapd on

service rpcbind start
service rpcidmapd start
service nfs start
service nfslock start

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 2049 -j ACCEPT
service iptables save