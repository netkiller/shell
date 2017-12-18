
vim /etc/logstash/logstash.yml <<EOF > /dev/null 2>&1
:37,37s/# pipeline.workers: 2/pipeline.workers: 8/
:41,41s/# pipeline.output.workers: 1/pipeline.output.workers: 4/
:45,45s/# pipeline.batch.size: 125/pipeline.batch.size: 125/
:wq
EOF
