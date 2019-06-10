#!/bin/bash

cp /etc/ssh/ssh_config{,.original}
#vim /etc/ssh/ssh_config <<EOF > /dev/null 2>&1
#:wq
#EOF

cat > /etc/profile.d/openssh.sh <<'EOF'
alias ssh='ssh -C -o ServerAliveInterval=30'
TMOUT=1800
EOF

source /etc/profile.d/openssh.sh

cat >> /etc/ssh/ssh_config <<'EOF'

  ServerAliveInterval 30
EOF
