echo > /var/log/wtmp
echo > /var/log/btmp
echo > /var/log/lastlog

rm -rf /var/log/wtmp-*
rm -rf /var/log/btmp-*
rm -rf /var/log/lastlog-*

history -c
