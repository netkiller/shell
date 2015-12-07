#!/bin/bash

cat >> ~/.bashrc <<EOF

alias php='php -d error_log=/var/tmp/php_errors.log -c /srv/php/etc/php-cli.ini'
PATH=$PATH:/srv/php/bin:
EOF

cat >> /etc/man.config <<EOF
MANPATH  /srv/php/man/
EOF

cat >> /etc/profile.d/php.sh <<'EOF'
export PATH=/srv/php/bin:$PATH
EOF

source /etc/profile.d/php.sh