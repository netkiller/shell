
cat <<EOF | mongo
use admin
db.addUser('admin','chen')
db.system.users.find()
exit
EOF

echo "admin password: chen"
