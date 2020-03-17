#!/bin/bash

IMAGES=(ca peer orderer couchdb ccenv kafka zookeeper tools javaenv)
#FABRIC_TAG=x86_64-2.0.0
FABRIC_TAG=latest

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

for IMAGE in ${IMAGES}; do
    echo "==> FABRIC IMAGE: $IMAGE"
    echo
    docker pull hyperledger/fabric-$IMAGE:$FABRIC_TAG
    docker tag hyperledger/fabric-$IMAGE:$FABRIC_TAG hyperledger/fabric-$IMAGE
    echo
done

[[ $? -ne 0 ]] && echo "Error: Docker images" &&  exit $?

docker images

#if [ $(id -u) != "0" ]; then
#    sudo make install
#else
#	make install
#fi

curl -L --retry 5 --retry-delay 3 https://github.com/hyperledger/fabric/releases/download/v2.0.1/hyperledger-fabric-linux-amd64-2.0.1.tar.gz | tar xz
curl -L --retry 5 --retry-delay 3 https://github.com/hyperledger/fabric-ca/releases/download/v1.4.6/hyperledger-fabric-ca-linux-amd64-1.4.6.tar.gz | tar xz

mkdir -p /srv/hyperledger/fabric
mv bin config /srv/hyperledger/fabric
PATH=$PATH:/srv/hyperledger/fabric/bin

[[ $? -ne 0 ]] && echo "Error: install" &&  exit $?

cat > /etc/profile.d/fabric.sh <<'EOF'
export PATH=$PATH:/srv/hyperledger/fabric/bin
EOF

source /etc/profile.d/fabric.sh

# cp /file{,.original}

#vim /srv/ <<end > /dev/null 2>&1
#:wq
#end

#adduser fabric

#cat > /etc/sysconfig/fabric <<'EOF'
#NETWORKID=123456
#RPCADDR=0.0.0.0
#EOF

