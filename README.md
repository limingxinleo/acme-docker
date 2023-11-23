# 申请证书脚本

[acme.sh](https://github.com/acmesh-official/acme.sh)

## 安装

```shell
docker build . -t acme
docker volume create acme-data
```

## 启动服务

```shell
docker run --entrypoint /bin/sh -v acme-data:/root/.acme.sh -v $PWD/output:/output -it acme
```

## 申请证书

```shell
acme.sh --issue -d example.com -d '*.example.com' --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please
```

如果发现需要创建账户，则执行以下指令

```shell
acme.sh --register-account -m myemail@example.com --server zerossl
```

执行完后，会展示对应的 TXT 记录，你只需要在你的域名管理面板中添加这条 txt 记录即可.

```shell
acme.sh --renew -d example.com -d '*.example.com' --yes-I-know-dns-manual-mode-enough-go-ahead-please
```

## 复制证书

```shell
acme.sh --install-cert -d example.com -d '*.example.com' --key-file /output/key.pem --fullchain-file /output/cert.pem
```

## 配置 Nginx

将 output 目录中的证书上传到服务器上

```nginx configuration
server {
    listen 443 ssl;
    server_name *.example.com;
    ssl_certificate /etc/nginx/conf.d/ssl/output/cert.pem;
    ssl_certificate_key /etc/nginx/conf.d/ssl/output/key.pem;
    # 若ssl_certificate_key使用33iq.key，则每次启动Nginx服务器都要求输入key的密码。
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers "EECDH+ECDSA+AESGCM EECDH+aRSA+AESGCM EECDH+ECDSA+SHA384EECDH+ECDSA+SHA256 EECDH+aRSA+SHA384 EECDH+aRSA+SHA256 EECDH+aRSA+RC4EECDH EDH+aRSA RC4 !aNULL !eNULL !LOW !3DES !MD5 !EXP !PSK !SRP !DSS !MEDIUM";

    proxy_set_header    Host                $host:$server_port;
    proxy_set_header    X-Real-IP           $remote_addr;
    proxy_set_header    X-Real-PORT         $remote_port;
    proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;

    location / {
        proxy_pass      http://127.0.0.1:80;
    }
}

```
