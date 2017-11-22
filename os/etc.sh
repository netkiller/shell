#!/bin/bash
cat >> /etc/profile.d/history.sh <<EOF
# Administrator specific aliases and functions for system security
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export TIME_STYLE=long-iso
EOF

source /etc/profile.d/history.sh
