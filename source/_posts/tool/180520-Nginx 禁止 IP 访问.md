---
title: Nginx 禁止 IP 访问
permalink: nginx-ip-forbidden
date: 2018-05-20 21:00:00
updated: 2018-05-20 21:00:00
comments: true
toc: true
tags:
   - nginx
categories:
description:
---

禁止 IP 访问，其他域名跳转到 `www.xxx.com`：

```nginx
server {
    listen 80;
    server_name 55.66.77.88;
    deny all;
}

server {
    listen 80;
    server_name www.xxx.com xxx.com;

    return 301 https://www.xxx.com$request_uri;
}

server {
    listen 443 ssl http2;

    ...

    if ($host = 55.66.77.88) {
        return 403;
    }
    if ($host != 'www.xxx.com'){
        rewrite ^/(.*)$ https://www.xxx.com/$1 permanent;
    }

    ...
}
```
