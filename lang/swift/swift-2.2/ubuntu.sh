
wget https://swift.org/builds/ubuntu1510/swift-2.2-SNAPSHOT-2015-12-01-b/swift-2.2-SNAPSHOT-2015-12-01-b-ubuntu15.10.tar.gz
tar xvf swift-2.2-SNAPSHOT-2015-12-01-b-ubuntu15.10.tar.gz
sudo mv swift-2.2-SNAPSHOT-2015-12-01-b-ubuntu15.10/usr /usr/local/swift-2.2
sudo ln -s /usr/local/swift-2.2 /usr/local/swift

cat << 'SWIFT' >> ~/.bashrc

export SWIFT_HOME=/usr/local/swift
export PATH=$SWIFT_HOME/bin:$PATH
export LD_LIBRARY_PATH=$SWIFT_HOME/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$SWIFT_HOME/lib:$LIBRARY_PATH
SWIFT