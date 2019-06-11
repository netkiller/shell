passwd -u bin
passwd -u daemon
passwd -u adm
passwd -u lp
passwd -u sync
passwd -u shutdown
passwd -u halt
passwd -u mail
passwd -u operator
passwd -u games
passwd -u ftp
passwd -u nobody
passwd -u systemd-network
passwd -u dbus
passwd -u polkitd
passwd -u chrony
passwd -u ntp
passwd -u postfix

# chattr /etc/passwd /etc/shadow
chattr -i /etc/passwd
chattr -i /etc/group
chattr -i /etc/shadow*
chattr -i /etc/gshadow*

# history security
chattr -a /root/.bash_history
chattr -i /root/.bash_history