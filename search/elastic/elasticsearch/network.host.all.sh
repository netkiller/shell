
cat >> /etc/elasticsearch/elasticsearch.yml <<EOF
network.host: 0.0.0.0
EOF

systemctl restart elasticsearch.service
