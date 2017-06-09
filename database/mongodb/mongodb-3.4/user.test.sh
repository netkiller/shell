USER=test
PASSWORD=$(cat /dev/urandom | tr -dc "[:alnum:]" | head -c 32)
echo "User: $USER password: ${PASSWORD}"

cat <<EOF | mongo
use test;
db.createUser(
   {
     user: "${USER}",
     pwd: "${PASSWORD}",
     roles: [ "dbAdmin", "readWrite" ]
   }
);
exit
EOF

# db.system.users.find()