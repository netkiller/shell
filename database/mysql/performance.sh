sed -i 's/default/default,noatime,nodiratime,nobarrier/' /etc/fstab
echo "vm.swappiness = 0" >>/etc/sysctl.conf
#cat >> /etc/rc.local <<EOF

#echo deadline >/sys/block/sda/queue/scheduler
#EOF
#echo deadline >/sys/block/sda/queue/scheduler

chattr -R +A /var/lib/mysql
chattr -R +A /var/spool/
chattr -R +A /var/log

