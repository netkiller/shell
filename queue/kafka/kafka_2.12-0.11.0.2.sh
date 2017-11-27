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
wget http://mirrors.tuna.tsinghua.edu.cn/apache/kafka/0.11.0.2/kafka_2.12-0.11.0.2.tgz
tar zxvf kafka_2.12-0.11.0.2.tgz

cp kafka_2.12-0.11.0.2/config/server.properties{,.original}
echo "\r\n" >> kafka_2.12-0.11.0.2/config/server.properties
cat >> kafka_2.12-0.11.0.2/config/server.properties <<EOF

advertised.host.name=localhost
EOF

sed -i 's/broker.id=0/broker.id=1/' kafka_2.12-0.11.0.2/config/server.properties

cp kafka_2.12-0.11.0.2/config/consumer.properties{,.original}
cp kafka_2.12-0.11.0.2/config/zookeeper.properties{,.original}

mv kafka_2.12-0.11.0.2 /srv/kafka-0.11.0.2
ln -s /srv/kafka-0.11.0.2 /srv/kafka

#/srv/kafka/bin/zookeeper-server-start.sh -daemon /srv/kafka/config/zookeeper.properties
/srv/kafka/bin/kafka-server-start.sh -daemon /srv/kafka/config/server.properties

