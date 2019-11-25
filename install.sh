#!/bin/bash

if [ ! -f /usr/bin/git ]; then
	dnf install -y git
fi

git clone --depth=1 https://github.com/oscm/shell.git /srv/oscm

cat > /etc/profile.d/oscm.sh <<'EOF'
export PATH=/srv/oscm/bin:$PATH
EOF

source /etc/profile.d/oscm.sh

chmod +x /srv/oscm/ -R 