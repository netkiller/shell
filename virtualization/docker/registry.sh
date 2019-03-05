sudo tee /etc/docker/daemon.json << EOF
{ "insecure-registries":["0.0.0.0:5000"] }
EOF