#!/bin/bash

UUID=$(blkid | grep btrfs | sed -e 's/.*UUID="\([^"]*\)".*/\1/')
cat << EOF >> /etc/fstab
UUID=${UUID} /srv btrfs defaults 1 1
EOF

mount /srv
btrfs subvolume create /srv/@www

mv /www/* /srv/@www

cat << EOF >> /etc/fstab
UUID=${UUID} /www btrfs noatime,nodiratime,subvol=@www 0 2
EOF

mount /www

chown www:www -R /www