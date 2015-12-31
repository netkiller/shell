
yum install -y samba samba-client

cp /etc/samba/smb.conf{,.original}

systemctl enable smb
systemctl start smb

systemctl enable nmb
systemctl start nmb


