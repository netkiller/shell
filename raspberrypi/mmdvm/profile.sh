#!/bin/bash

#sudo cat >> /etc/profile.d/mmdvm.sh <<'EOF'
#export PATH=/srv/mmdvm/bin:$PATH
#EOF

cat << 'EOF' | sudo tee /etc/profile.d/mmdvm.sh && sudo chmod +x /etc/profile.d/mmdvm.sh
export PATH=/srv/mmdvm/bin:$PATH
EOF

source /etc/profile.d/mmdvm.sh