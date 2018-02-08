#!/bin/bash

FABRIC_TAG=x86_64-1.0.5

cd /usr/local/src/

if [ ! -f /usr/bin/bunzip2 ];then
    yum install -y bzip2
fi

if [ ! -f /usr/bin/git ];then
    yum install -y git
fi

if [ ! -f /usr/bin/go ];then
    yum install -y golang
fi

[[ $? -ne 0 ]] && echo "Error: installing some of software" &&  exit $?

for IMAGES in ca peer orderer couchdb ccenv javaenv kafka zookeeper tools; do
    echo "==> FABRIC IMAGE: $IMAGES"
    echo
    docker pull hyperledger/fabric-$IMAGES:$FABRIC_TAG
    docker tag hyperledger/fabric-$IMAGES:$FABRIC_TAG hyperledger/fabric-$IMAGES
done

[[ $? -ne 0 ]] && echo "Error: Docker images" &&  exit $?

docker images

#if [ $(id -u) != "0" ]; then
#    sudo make install
#else
#	make install
#fi

[[ $? -ne 0 ]] && echo "Error: install" &&  exit $?

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
NETWORKID=123456
RPCADDR=0.0.0.0
EOF

wget -q https://raw.githubusercontent.com/oscm/shell/master/blockchain/ethereum/centos/go-ethereum.service 
wget -q https://raw.githubusercontent.com/oscm/shell/master/blockchain/ethereum/centos/go-ethereum.service -O /usr/lib/systemd/system/go-ethereum.service

systemctl daemon-reload
systemctl enable go-ethereum
systemctl start go-ethereum
