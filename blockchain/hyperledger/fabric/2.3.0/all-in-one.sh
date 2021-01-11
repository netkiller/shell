docker pull hyperledger/fabric-ca:2.3.0
docker tag hyperledger/fabric-ca:2.3.0 hyperledger/fabric-ca

docker pull hyperledger/fabric-orderer:2.3.0
docker tag hyperledger/fabric-orderer:2.3.0 hyperledger/fabric-orderer

docker pull hyperledger/fabric-peer:2.3.0
docker tag hyperledger/fabric-peer:2.3.0 hyperledger/fabric-peer

docker pull hyperledger/fabric-couchdb:latest
docker tag hyperledger/fabric-couchdb:latest hyperledger/fabric-couchdb

docker pull hyperledger/fabric-tools:2.3.0
docker tag hyperledger/fabric-tools:2.3.0 hyperledger/fabric-tools    

docker pull hyperledger/fabric-ccenv:2.3.0
docker tag hyperledger/fabric-ccenv:2.3.0 hyperledger/fabric-ccenv

docker images
