cd /usr/local/src
wget http://mirrors.tuna.tsinghua.edu.cn/apache/flume/1.7.0/apache-flume-1.7.0-bin.tar.gz
tar zvf apache-flume-1.7.0-bin.tar.gz
mv apache-flume-1.7.0-bin /srv/apache-flume-1.7.0
ln -s /srv/apache-flume-1.7.0 /srv/apache-flume
cp /srv/apache-flume/conf/flume-env.sh.template /srv/apache-flume/conf/flume-env.sh
cp /srv/apache-flume/conf/flume-conf.properties.template /srv/apache-flume/conf/flume-conf.properties
