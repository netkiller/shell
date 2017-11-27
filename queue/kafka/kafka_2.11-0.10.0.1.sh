#!/bin/bash

cd /usr/local/src
wget http://apache.communilink.net/zookeeper/zookeeper-3.4.9/zookeeper-3.4.9.tar.gz
tar zxvf zookeeper-3.4.9.tar.gz
cp zookeeper-3.4.9/conf/zoo_sample.cfg zookeeper-3.4.9/conf/zoo.cfg
vim zookeeper-3.4.9/conf/zoo.cfg
mv zookeeper-3.4.9 /srv/
ln -s /srv/zookeeper-3.4.9 /srv/zookeeper
#cd zookeeper-3.4.9
/srv/zookeeper/bin/zkServer.sh start

cd /usr/local/src
wget http://apache.communilink.net/kafka/0.10.2.0/kafka_2.12-0.10.2.0.tgz
tar zxvf kafka_2.12-0.10.2.0.tgz
mv kafka_2.12-0.10.2.0 /srv/
cp /srv/kafka_2.12-0.10.2.0/config/server.properties{,.original}
echo "advertised.host.name=localhost" >> /srv/kafka_2.12-0.10.2.0/config/server.properties
cp /srv/kafka_2.12-0.10.2.0/config/consumer.properties{,.original}
ln -s /srv/kafka_2.12-0.10.2.0 /srv/kafka
/srv/kafka/bin/kafka-server-start.sh -daemon /srv/kafka/config/server.properties

