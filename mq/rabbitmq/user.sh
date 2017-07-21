rabbitmqctl add_user admin adminpass
rabbitmqctl set_user_tags admin administrator
rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"

## Delete default user. We can't risk it.
rabbitmqctl delete_user guest
