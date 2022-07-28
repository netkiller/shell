cat > /etc/sysconfig/ethereum <<'EOF'
NETWORKID=444444
RPCADDR=0.0.0.0
EOF

wget -q https://raw.githubusercontent.com/netkiller/shell/master/blockchain/ethereum/systemd/private.service -O /usr/lib/systemd/system/private.service

systemctl daemon-reload
systemctl enable private

cat > /home/ethereum/genesis.json <<'EOF'
{
  "nonce": "0x0000000000000042",
  "difficulty": "0x020000",
  "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "coinbase": "0x0000000000000000000000000000000000000000",
  "timestamp": "0x00",
  "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "extraData": "0x11bbe8db4e347b4e8c937c1c8370e4b5ed33adb3db69cbdb7a38e1e50b1b82fa",
  "gasLimit": "0x4c4b40",
  "config": {
      "chainId": 15,
      "homesteadBlock": 0,
      "eip155Block": 0,
      "eip158Block": 0
  },
  "alloc": { }
}
EOF

su - ethereum -c "geth init genesis.json"
su - ethereum -c "geth account new"

systemctl start private