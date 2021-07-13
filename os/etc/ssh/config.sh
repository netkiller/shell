cat > ~/.ssh/config <<'EOF'
Host *
	ServerAliveInterval=30
	StrictHostKeyChecking no
	UserKnownHostsFile=/dev/null
EOF

chmod 600 -R ~/.ssh/config