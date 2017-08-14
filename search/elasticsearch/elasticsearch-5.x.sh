rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

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


cat >> /etc/sysctl.d/elasticsearch.conf <<EOF
# Set up for elasticsearch
# Author netkiller@msn.com
# Website http://netkiller.github.io

vm.max_map_count=655360
EOF

sysctl -p /etc/sysctl.d/elasticsearch.conf

cat >> /etc/security/limits.d/20-nofile.conf <<EOF

# Set up for elasticsearch
# Author netkiller@msn.com
# Website http://netkiller.github.io

elasticsearch soft nofile 65535
elasticsearch hard nofile 65535
EOF

cat >> /etc/security/limits.d/20-nproc.conf <<EOF

# Set up for elasticsearch
# Author netkiller@msn.com
# Website http://netkiller.github.io
elasticsearch soft nproc 1024
elasticsearch soft nproc 2048
EOF

systemctl daemon-reload
systemctl enable elasticsearch.service
systemctl start elasticsearch.service
