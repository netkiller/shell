MongoDB
=====

## MongoDB 4.x

	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mongodb/mongodb.org/mongodb-4.x.sh | bash

## Config

### bind 0.0.0.0
	
	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mongodb/mongodb.org/net.bindIp.all.sh | bash
	
### enable auth
	
	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mongodb/mongodb-org/security.authorization.enabled.sh | bash
	
	
## Tools

	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mongodb/mongodb.org/mongodb-org-tools.sh | bash
	

## Administrator

```
use admin;
db.createUser(
   {
     user: "admin",
     pwd: "chen",
     roles: [ "dbAdmin", "dbOwner", "userAdmin" ]
   }
);

use products
db.createUser(
   {
     user: "accountUser",
     pwd: "password",
     roles: [ "readWrite", "dbAdmin" ]
   }
)
```

	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mongodb/mongodb.org/security.authorization.enabled.sh | bash



- - -

## Install 3.x 

	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mongodb/mongodb.org/mongodb-3.6.sh | bash

	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/mongodb/mongodb-3.4/install.sh | bash
	
