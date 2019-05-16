# Godaddy SSL

## UCC SSL

生成 CSR 
 
openssl req -new -newkey rsa:2048 -nodes -keyout 您的域名.key -out 您的域名.csr

提交 CSR 生成证书，下来证书，证书文件夹有两个 CRT文件，将两个文件合并到一个文件即可。

