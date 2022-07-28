#!/bin/bash

cd /usr/local/src/

if [ ! -f /usr/bin/bunzip2 ];then
    dnf install -y bzip2
fi

if [ ! -f /usr/bin/git ];then
    dnf install -y git
fi

if [ ! -f /usr/bin/go ];then
    dnf install -y golang
fi

[[ $? -ne 0 ]] && echo "Error: installing some of software" &&  exit $?

if [ ! -f v1.8.3.tar.gz ];then
	wget https://github.com/ethereum/go-ethereum/archive/v1.8.3.tar.gz
fi

if [ -s v1.8.3.tar.gz ]; then

tar zxvf v1.8.3.tar.gz
cd go-ethereum-1.8.3/
gmake all

cp -r build /srv/go-ethereum-1.8.3

fi

[[ $? -ne 0 ]] && echo "Error: gmake" &&  exit $?

#if [ $(id -u) != "0" ]; then
#    sudo make install
#else
#	make install
#fi

rm -f /srv/go-ethereum
ln -s /srv/go-ethereum-1.8.3 /srv/go-ethereum

[[ $? -ne 0 ]] && echo "Error: install" &&  exit $?

strip /srv/go-ethereum/bin/geth

cat > /etc/profile.d/go-ethereum.sh <<'EOF'
export PATH=$PATH:/srv/go-ethereum/bin
EOF

source /etc/profile.d/go-ethereum.sh

# cp /file{,.original}

#vim /srv/ <<end > /dev/null 2>&1
#:wq
#end

adduser ethereum

cat > /etc/sysconfig/go-ethereum <<'EOF'
NETWORKID=4444
RPCADDR=0.0.0.0
EOF

wget -q https://raw.githubusercontent.com/netkiller/shell/master/blockchain/ethereum/centos/go-ethereum.service 
wget -q https://raw.githubusercontent.com/netkiller/shell/master/blockchain/ethereum/centos/go-ethereum.service -O /usr/lib/systemd/system/go-ethereum.service

systemctl daemon-reload
systemctl enable go-ethereum
systemctl start go-ethereum
