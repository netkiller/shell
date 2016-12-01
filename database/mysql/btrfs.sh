#!/bin/sh

systemctl stop mysqld

btrfs subvolume create /srv/@mysql
btrfs subvolume list /srv/

UUID=$(blkid | grep btrfs | sed -e 's/.*UUID="\([^"]*\)".*/\1/')
# UUID=786f570d-fe5c-4d5f-832a-c1b0963dd4e6 /srv btrfs defaults 1 1
cat << EOF >> /etc/fstab
UUID=${UUID} /var/lib/mysql  btrfs   noatime,nodiratime,subvol=@mysql 0 2
EOF

mkdir /tmp/mysql
mv /var/lib/mysql/* /tmp/mysql/

mount /var/lib/mysql/
chown mysql:mysql /var/lib/mysql

mv /tmp/mysql/* /var/lib/mysql/

systemctl start mysqld
