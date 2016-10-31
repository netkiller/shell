	for email in $(curl -s https://raw.githubusercontent.com/oscm/shell/master/monitor/mail/timeout.sh | bash) 
	do
		echo "UPDATE contact SET status='Unsubscribe' where status='Subscription' and email_digest=md5('$email');" 
	done