
cd /usr/local/src
wget http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-2.8.1/hadoop-2.8.1.tar.gz
tar zxf hadoop-2.8.1.tar.gz
mv hadoop-2.8.1 /srv/apache-hadoop-2.8.1
ln -s /srv/apache-hadoop-2.8.1 /srv/apache-hadoop
adduser hadoop

su - hadoop
ssh-keygen -f ~/.ssh/id_rsa -C hadoop
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
