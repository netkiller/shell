cd /usr/local/src
wget http://mirror.bit.edu.cn/apache/hbase/1.3.1/hbase-1.3.1-bin.tar.gz

tar zxf hbase-1.3.1-bin.tar.gz
cp hbase-1.3.1/conf/hbase-site.xml{,.original}
mv hbase-1.3.1 /srv/apache-hbase-1.3.1
ln -s /srv/apache-hbase-1.3.1 /srv/apache-hbase
