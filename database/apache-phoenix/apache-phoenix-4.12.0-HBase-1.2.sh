cd /usr/local/src/
wget https://mirrors.tuna.tsinghua.edu.cn/apache/phoenix/apache-phoenix-4.12.0-HBase-1.2/bin/apache-phoenix-4.12.0-HBase-1.2-bin.tar.gz		
tar zxvf apache-phoenix-4.12.0-HBase-1.2-bin.tar.gz 
cp apache-phoenix-4.12.0-HBase-1.2-bin/phoenix-core-4.12.0-HBase-1.2.jar /srv/apache-hbase-1.2.6/lib
mv apache-phoenix-4.12.0-HBase-1.2-bin /srv/apache-phoenix-4.12.0-HBase-1.2
rm -f /srv/apache-phoenix 
ln -s /srv/apache-phoenix-4.12.0-HBase-1.2 /srv/apache-phoenix

chown hadoop:hadoop -R /srv/apache-phoenix*

su - hadoop

cat >> ~/.bash_profile << 'EOF'
export CLASSPATH=$CLASSPATH:/srv/apache-phoenix
export PATH=$PATH:/srv/apache-phoenix/bin
EOF


