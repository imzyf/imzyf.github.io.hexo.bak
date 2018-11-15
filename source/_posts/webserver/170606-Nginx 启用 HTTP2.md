---
title: Nginx 启用 HTTP/2
permalink: nginx-enable-http2
date: 2017-06-06 21:00:00
comments: true
toc: true
tags:
   - nginx
   - https
---

2015年5月14日 HTTP/2 协议正式版的发布，越来越多的网站开始部署 HTTP/2 了。

HTTP/2 协议是从 SPDY 演变而来，SPDY 已经完成了使命并很快就会退出历史舞台（例如 Chrome 在 2016 年初结束对 SPDY 的支持；Nginx 在 15 年年底正式支持 HTTP/2 后，也不再支持 SPDY）。

[HTTP/2: the Future of the Internet | Akamai](https://http2.akamai.com/demo) 提供了 HTTP/1 和 HTTP/2 的加载速度对比。

## HTTP/2 中的特性

- 多路复用：通过多个请求 stream 共享一个 TCP 连接的方式，解决了 HTTP1.x holb (head of line blocking) 的问题，降低了延迟同时提高了带宽的利用率。
- 压缩头部：HTTP/2 规定了在客户端和服务器端会使用并且维护“首部表”，来跟踪和存储之前发送的键值对，对于相同的头部，不必再通过请求发送，只需发送一次。
- 二进制分帧：在应用层与传输层之间增加一个二进制分帧层，以此达到：在不改动 HTTP 的语义，HTTP 方法、状态码、URI 及首部字段的情况下，突破 HTTP1.1 的性能限制，改进传输性能，实现低延迟和高吞吐量。

以下配置是在 Ubuntu 14.04 LTS 下。Ubuntu 14.04 LTS 中 Nginx、OpenSSL 的默认版本都是比较低的所以需要升级。

<!-- more -->

## install OpenSSL

``` bash
sudo wget openssl.org/source/openssl-1.0.2l.tar.gz
sudo tar -xvzfopenssl-1.0.2l.tar.gz
cd openssl-1.0.2l
sudo ./config --prefix=/usr/
sudo make depend
sudo make install
openssl version
```

## install Nginx

### apt-get

``` bash
# 添加源
sudo vim /etc/apt/sources.list.d/nginx.list
```
add:
```
deb http://nginx.org/packages/ubuntu/ trusty nginx
deb-src http://nginx.org/packages/ubuntu/ trusty nginx
```
``` bash
# 添加签名
wget -q "http://nginx.org/packages/keys/nginx_signing.key" -O-| sudo apt-key add -
sudo apt-get update
```
这样可以安装上比较新的 Nginx 版本应该就够用了。

### make

因为我使用了 `ngx_pagespeed` 模块，所以我采用的是源码编译安装的方式

[nginx: download](http://nginx.org/en/download.html) 下载源码，编译 [Module ngx_http_v2_module](http://nginx.org/en/docs/http/ngx_http_v2_module.html)

``` bash
# 需要添加 http_v2_module 和 --with-openssl
sudo ./configure --with-http_v2_module --with-openssl=../openssl-1.0.2l
```
这里只写了 HTTP/2 涉及的模块，其他参数按需添加
``` bash
sudo make
sudo make install
```

## Nginx configuration

```
server {
    listen 443 default_server ssl http2;
    listen [::]:443 default_server ssl http2;
    ...
}
```

## test

访问你的网站，在 Chrome Network 中勾选 `Protocol`，可以看到 `h2`

## other

根据 [&#12302;  Nginx启用HTTP/2&#12303; 有槽必吐 - 不吐槽，毋宁死](https://tsukkomi.org/post/enable-http-2-on-nginx) 的经验，在 Ubuntu 16.04 LTS 下只要配置 Nginx server 块就可以了。

Chrome 插件 [HTTP/2 and SPDY indicator](https://chrome.google.com/webstore/detail/http2-and-spdy-indicator/mpbpobfflnpcgagjijhmgnchggcjblin?hl=en-US) 如果网站是 HTTP/2 就会显示蓝色，如果是 SPDY（HTTP/2的前身）就会显示绿色，如果没有则显示灰色。

> Reference:
> - [HTTP/2.0 相比1.0有哪些重大改进？ - 知乎](https://www.zhihu.com/question/34074946)
> - [&#12302;  Nginx启用HTTP/2&#12303; 有槽必吐 - 不吐槽，毋宁死](https://tsukkomi.org/post/enable-http-2-on-nginx)
> - [http2讲解 · GitBook](https://www.gitbook.com/book/ye11ow/http2-explained/details)
