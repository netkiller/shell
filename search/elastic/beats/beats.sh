dnf install -y filebeat

cp /etc/filebeat/filebeat.yml{,.original}

systemctl daemon-reload
systemctl enable filebeat.service
systemctl start filebeat.service
