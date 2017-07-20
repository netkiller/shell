cd /usr/local/src
wget http://mirrors.tuna.tsinghua.edu.cn/apache/flume/1.7.0/apache-flume-1.7.0-bin.tar.gz
tar zxf apache-flume-1.7.0-bin.tar.gz
cp apache-flume-1.7.0-bin/conf/flume-env.sh.template apache-flume-1.7.0-bin/conf/flume-env.sh
cp apache-flume-1.7.0-bin/conf/flume-conf.properties.template apache-flume-1.7.0-bin/conf/flume-conf.properties
mv apache-flume-1.7.0-bin /srv/apache-flume-1.7.0
ln -s /srv/apache-flume-1.7.0 /srv/apache-flume

