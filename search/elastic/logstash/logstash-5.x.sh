rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

cat >> /etc/dnf.repos.d/logstash.repo <<EOF
[logstash-5.x]
name=Elastic repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/dnf
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

dnf install -y logstash

cp /etc/logstash/logstash.yml{,.original}

systemctl daemon-reload
systemctl enable logstash.service
systemctl start logstash.service


