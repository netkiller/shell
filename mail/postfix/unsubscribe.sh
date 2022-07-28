##################################################
# Author: Neo <netkiller@msn.com>
# Home: http://netkiller.github.io
# Schedule for unsubscribe email.
##################################################
# Install MySQL Client
# curl -s https://raw.githubusercontent.com/netkiller/shell/master/database/mysql/mysql.client.sh | bash
##################################################
host=
user=
pass=
dbname=
maillist=unsubscribe.lst

curl -s https://raw.githubusercontent.com/netkiller/shell/master/log/mail/unsubscribe.sh | bash > ${maillist}

cat ${maillist} | mysql -h${host} -u${user} -p{pass} ${dbname}


