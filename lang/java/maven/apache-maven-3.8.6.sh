#!/bin/bash

dnf remove -y maven

cd /usr/local/src/
wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
tar zxf apache-maven-3.8.6-bin.tar.gz
mv apache-maven-3.8.6 /srv/
rm -f /srv/apache-maven
ln -s /srv/apache-maven-3.8.6 /srv/apache-maven

alternatives --remove mvn /usr/share/maven/bin/mvn
alternatives --install /usr/local/bin/mvn apache-maven-3.8.6 /srv/apache-maven-3.8.6/bin/mvn 0

cp /srv/apache-maven/conf/settings.xml{,.original}
vim /srv/apache-maven/conf/settings.xml <<end > /dev/null 2>&1
:158,158d
:164,164s/$/ -->/
:wq
end

mvn -v