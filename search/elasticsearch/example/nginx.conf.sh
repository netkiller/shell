upstream elasticsearch {
    server 127.0.0.1:9200;
    server 10.186.7.221:9200 backup;

    keepalive 15;
}

server {
    listen 80;
    server_name so.netkiller;

    charset utf-8;
    access_log /var/log/nginx/so.netkiller.cn.access.log;
    error_log /var/log/nginx/so.netkiller.cn.error.log;

    auth_basic "Protected Elasticsearch";
    auth_basic_user_file passwords;

    location ~* ^(/_cluster|/_nodes) {
        return 403;
        break;
    }

    location ~* _(cat|open|close|shutdown) {
        return 403;
        break;
    }
    location / {

        if ($request_method !~ ^(GET|HEAD|POST)$) {
            return 403;
        }

        proxy_pass http://elasticsearch;
        proxy_http_version 1.1;
        proxy_set_header Connection "Keep-Alive";
        proxy_set_header Proxy-Connection "Keep-Alive";
    }

}
