cat >> /etc/profile.d/apache-ant.sh <<'EOF'
export PATH=/srv/apache-ant/bin:$PATH
EOF

source /etc/profile.d/apache-ant.sh