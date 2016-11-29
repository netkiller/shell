for email in $(egrep -o "to=<(.*)>, .* Connection timed out" /var/log/maillog | sed -e "s/to=<\(.*\)>.*/\1/") 
do
	echo "UPDATE contact SET status='Unsubscribe' where status='Subscription' and email_digest=md5('$email');" 
done

egrep -o "to=<(.*)>, .* No route to host" /var/log/maillog | sed -e "s/to=<\(.*\)>.*/UPDATE contact SET status='Unsubscribe' where status='Subscription' and email_digest=md5('\1');/"