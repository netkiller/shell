
wget -O /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
chmod +x /usr/local/bin/gitlab-runner
useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
gitlab-runner start

mkdir -p /home/gitlab-runner/.ssh/
cat > /home/gitlab-runner/.ssh/config <<'EOF'
Host *
	StrictHostKeyChecking no
	UserKnownHostsFile=/dev/null
EOF

chmod 600 -R /home/gitlab-runner/.ssh
