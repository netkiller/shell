Apache Hbase
========

Install Hbase 1.3.1
-----
    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/apache-hbase/apache-hbase-1.3.1.sh | bash

## Configure

### File

仅用于单机安装，学习使用

    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/apache-hbase/conf.file.sh | bash
	
### HDFS

用于分布式安装，需要 Hadoop 

	curl -s https://raw.githubusercontent.com/oscm/shell/master/database/apache-hbase/conf.hdfs.sh | bash

### 配置环境变量

    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/apache-hbase/hbase-env.sh | bash

## Startup

    curl -s https://raw.githubusercontent.com/oscm/shell/master/database/apache-hbase/startup.sh | bash