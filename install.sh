#!/bin/bash

if [ ! -f /usr/bin/git ]; then
	dnf install -y git
fi

git clone --depth=1 https://github.com/netkiller/shell.git /srv/netkiller

cat > /etc/profile.d/netkiller.sh <<'EOF'
export PATH=/srv/netkiller/bin:$PATH
EOF

source /etc/profile.d/netkiller.sh

chmod +x /srv/netkiller/ -R 