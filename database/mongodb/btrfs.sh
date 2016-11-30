#!/bin/sh

systemctl stop mongod

btrfs subvolume create /srv/@mongo
btrfs subvolume list /srv/

UUID=$(blkid | grep btrfs | sed -e 's/.*UUID="\([^"]*\)".*/\1/')
# UUID=786f570d-fe5c-4d5f-832a-c1b0963dd4e6 /srv btrfs defaults 1 1
cat << EOF >> /etc/fstab
UUID=${UUID} /var/lib/mongo  btrfs   noatime,nodiratime,subvol=@mongo 0 2
EOF

mkdir /tmp/mongo
mv /var/lib/mongo/* /tmp/mongo/

mount /var/lib/mongo/
chown mongod:mongod /var/lib/mongo

mv /tmp/mongo/* /var/lib/mongo/

systemctl start mongod
