git clone https://github.com/postgrespro/rum
cd rum
make USE_PGXS=1
make USE_PGXS=1 install
make USE_PGXS=1 installcheck
psql DB -c "CREATE EXTENSION rum;"