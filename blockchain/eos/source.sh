cd /usr/local/src/
git clone https://github.com/EOSIO/eos --recursive
cd eos/
git submodule update --init --recursive

./eosio_build.sh

cd build
make install
