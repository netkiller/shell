
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh" | sudo bash
dnf install gitlab-runner

cp /etc/gitlab-runner/config.toml{,.original}

systemctl enable gitlab-runner

gitlab-runner register

mkdir -p /home/gitlab-runner/.ssh/
cat > /home/gitlab-runner/.ssh/config <<'EOF'
Host *
	StrictHostKeyChecking no
	UserKnownHostsFile=/dev/null
EOF

chmod 600 -R /home/gitlab-runner/.ssh
