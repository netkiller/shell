pip install shadowsocks
mkdir -p /etc/shadowsocks/
cat > /etc/shadowsocks/ssserver.json << EOF

{
    "server":"0.0.0.0",
    "server_port":8388,
    "local_port":1080,
    "password":"barfoo!",
    "timeout":600,
    "method":"chacha20-ietf-poly1305"
}

EOF

# "method": "aes-256-cfb",

ssserver -c /etc/shadowsocks/ssserver.json -d start