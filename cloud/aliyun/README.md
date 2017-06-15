Aliyun (阿里云)
=====

数据盘 
-----
阿里云会提供一个数据盘 /dev/vdb 通过下面脚本初始化分区

	curl -s https://raw.githubusercontent.com/oscm/shell/master/cloud/aliyun/vdb.exp.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/cloud/aliyun/srv.sh | bash

CentOS
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/personalise.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/user/www.sh | bash

Nginx
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/cloud/aliyun/nginx.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/web/nginx/ssi.sh | bash

PHP 7.0.0
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/cloud/aliyun/php.sh | bash
	
Redis
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/redis/redis.sh | bash
	
Tomcat 
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/web/tomcat/8.5/apache-tomcat-8.5.15.sh | bash