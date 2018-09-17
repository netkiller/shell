USER=dba
PASSWORD=$(cat /dev/urandom | tr -dc "[:alnum:]" | head -c 32)
echo "User: $USER password: ${PASSWORD}"

cat <<EOF | mongo
use admin;
db.createUser(
   {
     user: "${USER}",
     pwd: "${PASSWORD}",
     roles: [ "dbAdmin", "dbOwner", "userAdmin" ]
   }
);
exit
EOF

# db.system.users.find()