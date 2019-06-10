#!/bin/bash

cp /etc/ssh/ssh_config{,.original}
#vim /etc/ssh/ssh_config <<EOF > /dev/null 2>&1
#:wq
#EOF

cat >> /etc/ssh/ssh_config <<'EOF'

  ServerAliveInterval 30
EOF
