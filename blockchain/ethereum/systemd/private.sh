cat > /etc/sysconfig/ethereum <<'EOF'
NETWORKID=4444
RPCADDR=0.0.0.0
EOF

wget -q https://raw.githubusercontent.com/oscm/shell/master/blockchain/ethereum/systemd/private.service -O /usr/lib/systemd/system/private.service

systemctl daemon-reload
systemctl enable private
systemctl start private