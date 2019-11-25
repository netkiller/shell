rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

cat >> /etc/dnf.repos.d/kibana.repo <<EOF
[kibana-5.x]
name=Kibana repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/dnf
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

dnf install -y kibana

cp /etc/kibana/kibana.yml{,.original}

systemctl daemon-reload
systemctl enable kibana.service
systemctl start kibana.service

# http://localhost:5601


