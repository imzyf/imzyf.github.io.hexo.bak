---
title: 使用 Let's Encrypt 通配符证书
permalink: lets-encrypt-wildcard-certificates
date: 2018-04-26 16:00:00
updated: 2018-04-26 16:00:00
comments: true
toc: true
tags:
   - https
categories:
description:
---

一直在使用 [Let's Encrypt](https://letsencrypt.org/) 的免费 SSL 证书，但是一直没做笔记。今天看到 Let's Encrypt 支持了通配符证书（Wildcard Certificates），也就是说二级子域名和主域名可以共用一个证书。

## 申请证书

```
# 下载证书申请客户端
cd /opt
git clone https://github.com/certbot/certbot
cd /opt/certbot

# 注意通配符并不包含主域名，所以要配置两个
./certbot-auto certonly -d *.zyf.im -d zyf.im --manual --preferred-challenges dns --server "https://acme-v02.api.letsencrypt.org/directory"
```

<!-- more -->

`-preferred-challenges dns` 使用 DNS 方式校验域名所有权，所以会遇到：

```
-------------------------------------------------------------------------------
Please deploy a DNS TXT record under the name
_acme-challenge.zyf.im with the following value:

YZ2unEViXH8nYZ2unEViIbW52LhIEViIbW52Lh

Before continuing, verify the record is deployed.
-------------------------------------------------------------------------------
Press Enter to Continue
```

要在域名服务商那里将 `_acme-challenge.zyf.im` 配置 DNS TXT 记录，从而校验域名所有权。

使用 `host -t txt _acme-challenge.zyf.im` 验证记录是否已经生效，如果看到对应的值，按 Enter 继续。

```
...
 - Congratulations!
...
```

生成的证书会放置在 `/etc/letsencrypt/live/`，可以使用 openssl 验证一下：

```
$ openssl x509 -in /etc/letsencrypt/live/zyf.im/cert.pem -noout -text | grep zyf.im

Subject: CN=zyf.im
        DNS:*.zyf.im DNS:zyf.im
```

## 配置证书

```
server {
    listen 80;
    server_name zyf.im design.zyf.im;
    return 301 https://$host$request_uri;
}
```

```
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    server_name design.zyf.im;
    root /project/imzyf;
    index index.html index.htm;

    ssl_certificate  /etc/letsencrypt/live/zyf.im/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/zyf.im/privkey.pem;
    ssl_session_timeout 1d;

    # Diffie-Hellman parameter for DHE ciphersuites, recommended 2048 bits
    ssl_dhparam /etc/nginx/ssl/dhparam.pem;:q!

    # intermediate configuration. tweak to your needs.
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers '...';
    ssl_prefer_server_ciphers on;

    # HSTS (ngx_http_headers_module is required) (15768000 seconds = 6 months)
    add_header Strict-Transport-Security max-age=15768000;

    # OCSP Stapling ---
    # fetch OCSP records from URL in ssl_certificate and cache them
    ssl_stapling on;
    ssl_stapling_verify on;
}
```

## 证书续期

证书的有效期只有三个月，所以要利用 `crontab` 定时续期：

```
30 2 * * 1 /opt/certbot/certbot-auto renew >> /var/log/le-renew.log 2>&1
35 2 * * 1 /etc/init.d/nginx reload
```

> Reference:
>
> - [配置使用免费的通配符证书](https://blog.laisky.com/p/letsencrypt/)
