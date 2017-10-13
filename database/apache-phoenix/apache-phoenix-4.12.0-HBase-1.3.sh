cd /usr/local/src/
wget https://mirrors.tuna.tsinghua.edu.cn/apache/phoenix/apache-phoenix-4.12.0-HBase-1.3/bin/apache-phoenix-4.12.0-HBase-1.3-bin.tar.gz		
tar zxvf apache-phoenix-4.12.0-HBase-1.3-bin.tar.gz 
cp apache-phoenix-4.12.0-HBase-1.3-bin/phoenix-core-4.12.0-HBase-1.3.jar /srv/apache-hbase-1.3.1/lib/
mv apache-phoenix-4.12.0-HBase-1.3-bin /srv/apache-phoenix-4.12.0-HBase-1.3
rm -f /srv/apache-phoenix
ln -s /srv/apache-phoenix-4.12.0-HBase-1.3 /srv/apache-phoenix

cat >> ~/.bash_profile << 'EOF'
export CLASSPATH=$CLASSPATH:/srv/apache-phoenix
export PATH=$PATH:/srv/apache-phoenix/bin
EOF

