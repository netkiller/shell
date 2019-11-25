
dnf localinstall ~/jdk-8u73-linux-x64.rpm

rm -f /srv/java
ln -s /usr/java/jdk1.8.0_73 /srv/java