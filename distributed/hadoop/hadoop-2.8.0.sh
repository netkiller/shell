
cd /usr/local/src
wget http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-2.8.0/hadoop-2.8.0.tar.gz
tar zxf hadoop-2.8.0.tar.gz
mv hadoop-2.8.0 /srv/apache-hadoop-2.8.0
ln -s /srv/apache-hadoop-2.8.0 /srv/apache-hadoop

mkdir -p /opt/hadoop/volume/{namenode,datanode}
chown -R hadoop:hadoop /srv/apache-hadoop* /opt/hadoop

cp /srv/apache-hadoop/etc/hadoop/hadoop-env.sh{,.original}
sed -i "25s:\${JAVA_HOME}:/usr/java/default:" hadoop-env.sh

adduser hadoop

chown hadoop:hadoop -R /srv/apache-hadoop-2.8.0

su - hadoop
ssh-keygen -f ~/.ssh/id_rsa -C hadoop
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

/srv/apache-hadoop/bin/hdfs namenode -format
find /opt/hadoop/volume/

cat >> ~/.bash_profile << EOF
export PATH=$PATH:/srv/apache-hadoop/bin:/srv/apache-hadoop/sbin:
EOF

source ~/.bash_profile
