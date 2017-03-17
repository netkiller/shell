rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch

cat >> /etc/yum.repos.d/elasticsearch.repo <<EOF
[elasticsearch-5.x]
name=Elasticsearch repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

yum install -y elasticsearch

cp /etc/elasticsearch/elasticsearch.yml{,.original}
cp /etc/elasticsearch/logging.yml{,.original}

systemctl daemon-reload
systemctl enable elasticsearch.service
