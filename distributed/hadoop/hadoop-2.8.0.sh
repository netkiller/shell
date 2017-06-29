
cd /usr/local/src
wget http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-2.8.0/hadoop-2.8.0.tar.gz
tar zxf hadoop-2.8.0.tar.gz
mv hadoop-2.8.0 /srv/
ln -s /srv/hadoop-2.8.0 /srv/hadoop
adduser hadoop