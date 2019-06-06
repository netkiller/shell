#!/bin/bash

cd /usr/local/src/
wget https://services.gradle.org/distributions/gradle-5.4.1-bin.zip
unzip gradle-5.4.1-bin.zip
mv gradle-5.4.1 /srv/
ln -s /srv/gradle-5.4.1 /srv/gradle

alternatives --install /usr/local/bin/gradle gradle /srv/gradle-5.4.1/bin/gradle 100

gradle -v