#!/bin/bash

cd /usr/local/src/
wget https://download.oracle.com/otn/java/jdk/8u212-b10/59066701cf1a433da9770636fbc4c9aa/server-jre-8u212-linux-x64.tar.gz?AuthParam=1559634424_e6ffa282a0bd3b9a68e18421908e99e8
tar zxf server-jre-8u212-linux-x64.tar.gz*
mv jdk1.8.0_212 /srv/
ln -s /srv/jdk1.8.0_212 /srv/java

cat >> /etc/profile.d/java.sh <<'EOF'
export JAVA_HOME=/srv/java
export JAVA_OPTS="-server -Xms512m -Xmx8192m"
export CLASSPATH=$JAVA_HOME/lib:$JAVA_HOME/jre/lib:.
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:
EOF

sed -i '117s/securerandom.source/#securerandom.source/' /srv/java/jre/lib/security/java.security
sed -i '117isecurerandom.source=file:/dev/./urandom' /srv/java/jre/lib/security/java.security

cat >> /etc/man.config <<EOF
MANPATH  /srv/java/man
EOF

alternatives --install /usr/bin/java java /srv/jdk1.8.0_212/bin/java 100 \
	--family java-1.8.0-server-jre \
	--slave /usr/bin/javac javac /srv/jdk1.8.0_212/bin/javac
	
alternatives --config java	