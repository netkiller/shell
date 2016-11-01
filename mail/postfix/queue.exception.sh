for id in $(mailq | egrep -B1 "(Connection refused|No route to host|Connection timed out)" | grep "@" | cut -d " " -f1)
do
postsuper -d $id
done 

