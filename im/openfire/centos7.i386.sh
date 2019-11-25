
dnf install -y java 

#libldb

dnf install -y "http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire-4.0.4-1.i386.rpm"

systemctl enable openfire

systemctl start openfire