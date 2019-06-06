cat >> /etc/profile.d/apache-maven.sh <<'EOF'
export PATH=/srv/apache-maven/bin:$PATH
EOF

source /etc/profile.d/apache-maven.sh