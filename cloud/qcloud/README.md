Qcloud (腾讯云)
=====

数据盘 
-----
阿里云会提供一个数据盘 /dev/vdb 通过下面脚本初始化分区

	curl -s https://raw.githubusercontent.com/oscm/shell/master/cloud/qcloud/vdb.exp.sh | bash

CentOS
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/personalise.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/os/user/www.sh | bash

Nginx
-----
	curl -s https://raw.githubusercontent.com/oscm/shell/master/cloud/qcloud/nginx.sh | bash
	curl -s https://raw.githubusercontent.com/oscm/shell/master/web/nginx/ssi.sh | bash