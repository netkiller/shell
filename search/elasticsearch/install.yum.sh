rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch

cat >> /etc/yum.repos.d/elasticsearch.repo <<EOF
[elasticsearch-2.x]
name=Elasticsearch repository for 2.x packages
baseurl=https://packages.elastic.co/elasticsearch/2.x/centos
gpgcheck=1
gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1
EOF

yum install -y elasticsearch

cp /etc/elasticsearch/elasticsearch.yml{,.original}
cp /etc/elasticsearch/logging.yml{,.original}

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service