Apache Tomcat
=====

Install
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/user/www.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/web/tomcat/apache-tomcat.sh | bash
	
systemd
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/web/tomcat/systemctl.sh | bash
	
Create a test file
-----
	wget -O /srv/apache-tomcat/webapps/ROOT/index.jsp https://raw.githubusercontent.com/oscm/shell/master/web/tomcat/webapps/ROOT/index.jsp

Test
-----
	# curl http://203.88.168.157:8080/

	<HTML>
	<HEAD>
	<TITLE>HelloWorld!</TITLE>
	</HEAD>
	<BODY>
	<h1>Hello World!</h1>

	</BODY>
	</HTML>
