
#dnf localinstall ~/jdk-8u73-linux-x64.rpm

mv jdk1.8.0_291 /srv/
rm -f /srv/java
ln -s /srv/jdk1.8.0_291 /srv/java

alternatives --install /usr/local/bin/java java /srv/jdk1.8.0_291/jre/bin/java 0
alternatives --install /usr/local/bin/javac javac /srv/jdk1.8.0_291/bin/javac 0