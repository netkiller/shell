yum install -y vsftpd

systemctl enable vsftpd

cp /etc/vsftpd/vsftpd.conf{,.original}

sed -i 's/anonymous_enable=YES/anonymous_enable=NO/' /etc/vsftpd/vsftpd.conf
sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/' /etc/vsftpd/vsftpd.conf
sed -i 's/listen=NO/listen=YES/' /etc/vsftpd/vsftpd.conf
sed -i 's/listen_ipv6=YES/listen_ipv6=NO/' /etc/vsftpd/vsftpd.conf

echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf

sed -i 's/IPTABLES_MODULES=""/IPTABLES_MODULES="ip_conntrack_ftp"/' /etc/sysconfig/iptables-config

systemctl start vsftpd

# firewall-cmd --permanent --add-port=21/tcp