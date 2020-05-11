---
title: Linux Mac 使用代理连接 SSH
permalink: linux-or-mac-ssh-by-proxy
date: 2017-10-28 15:00:00
updated: 2020-03-25 22:59:22
tags:
  - linux
  - mac
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

## Ubuntu

```bash
ssh -oProxyCommand="nc -x 127.0.0.1:1080 %h %p" ubuntu@111.111.1.1
```

## Mac

```bash
ssh -o "ProxyCommand nc -X 5 -x 127.0.0.1:1080 %h %p" ubuntu@111.111.1.1
```

<!-- more -->

## SecoureCRT

Session Options - Connection - SSH2 - Firewall，创建、选择代理。

## 参数

- `-o ProxyCommand`：SSH 命令选项，你可以理解成使用 “在 SSH 中使用代理”。
- `nc`：netcat 命令。
- `127.0.0.1:1080`：本地 Shadowsocks 的监听地址和监听端口。

## 命令行 HTTP 代理

```bash
export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;
```

## 鉴别自己是否真的使用了代理来登陆服务器

```bash
root@ubuntu:~# who
root     pts/2        2017-05-13 18:13 (xxx.xxx.xxx.xxx)
```

## References

- [Mac OS 使用 shadowsock 来代理 ssh 访问服务器](https://www.goodspb.net/mac-os-%E4%BD%BF%E7%94%A8-shadowsock-%E6%9D%A5%E4%BB%A3%E7%90%86-ssh-%E8%AE%BF%E9%97%AE%E6%9C%8D%E5%8A%A1%E5%99%A8/)

-- EOF --
