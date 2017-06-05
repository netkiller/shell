
if [ ! -f /etc/profile.d/node.sh ]; then

cat >> /etc/profile.d/node.sh <<'EOF'
export PATH=$PATH:/srv/node/bin:
EOF

cat >> /etc/man.config <<EOF
MANPATH /srv/node/share/man
EOF

source /etc/profile.d/node.sh

fi

