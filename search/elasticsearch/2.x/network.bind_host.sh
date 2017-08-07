
cat >> /etc/elasticsearch/elasticsearch.yml <<EOF
network.bind_host: "0.0.0.0"
network.publish_host: _non_loopback:ipv4_

EOF

systemctl restart elasticsearch.service