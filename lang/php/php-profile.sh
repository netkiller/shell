#!/bin/bash

cat >> ~/.bashrc <<EOF
export PHP_INI_SCAN_DIR=/srv/php/etc/cli.d
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