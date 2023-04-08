
cd /usr/local/src

#curl -LO -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u181-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u181-linux-x64.rpm
wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.rpm

dnf localinstall -y jdk-8u181-linux-x64.rpm

rm -f /srv/java
ln -s /usr/java/default /srv/java

# alternatives --install /usr/bin/java java /usr/java/jdk1.8.0_361-amd64/jre/bin/java 0
# alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0_361-amd64/bin/javac 0