#!/bin/bash

wget http://www.us.apache.org/dist/lucene/solr/5.3.0/solr-5.3.0.tgz

tar zxvf solr-5.3.0.tgz 

yum install -y java-1.8.0-openjdk unzip lsof

mv solr-5.3.0 /srv/

ln -s /srv/solr-5.3.0/ /srv/solr


-s /sbin/nologin
adduser -d /srv/solr -c "Apache Solr" solr
chown solr:solr -R /srv/solr-5.3.0

cp /srv/solr-5.3.0/bin/init.d/solr /etc/init.d/
sed -i 's:/opt/solr:/srv/solr:' /etc/init.d/solr
sed -i 's:/var/solr:/srv/solr/bin:' /etc/init.d/solr

chkconfig --add  solr
chkconfig solr on


