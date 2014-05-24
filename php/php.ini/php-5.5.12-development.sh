
cp /srv/php/etc/php.ini-development /srv/php/etc/php.ini
vim /srv/php/etc/php.ini <<EOF > /dev/null 2>&1
:299,299s$; =$open_basedir = /www/:/tmp/:/var/tmp/:/srv/php-5.5.12/lib/php/:/srv/php-5.5.12/bin/$
:366,366s/ = On/expose_php = Off/
:758,758s/;cgi.=1/cgi.fix_pathinfo=1/
:913,913s$;date. =$date.timezone = Asia/Hong_Kong$
:1390,1390s:; = "/tmp":session.save_path = "/dev/shm":
:1416,1416s/= PHPSESSID/session.name = JSESSIONID/
:wq
EOF
