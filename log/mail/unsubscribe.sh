for email in $(curl -s https://raw.githubusercontent.com/oscm/shell/master/log/mail/timeout.sh | bash) 
do
	echo "UPDATE contact SET status='Unsubscribe' where status='Subscription' and email_digest=md5('$email');" 
done

egrep -o "to=<(.*)>, .* No route to host" /var/log/maillog | sed -e "s/to=<\(.*\)>.*/UPDATE contact SET status='Unsubscribe' where status='Subscription' and email_digest=md5('\1');/"