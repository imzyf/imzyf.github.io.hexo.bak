---
title: Ubuntu Mac 使用 Shadowsocks 代理连接 SSH
permalink: ubuntu-or-mac-ssh-by-shadowsocks
date: 2017-10-28 15:00:00
comments: true
toc: true
tags:
   - mac
categories:
description:
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

## 参数

- `-o ProxyCommand`：SSH 命令选项，你可以理解成使用 “在 SSH 中使用代理”。
- `nc`：netcat 命令。
- `127.0.0.1:1080`：本地 Shadowsocks 的监听地址和监听端口。

## 鉴别自己是否真的使用了代理来登陆服务器

```
root@ubuntu:~# who
root     pts/2        2017-05-13 18:13 (xxx.xxx.xxx.xxx)
```

> Reference:
>
> - [Mac OS 使用 shadowsock 来代理 ssh 访问服务器](https://www.goodspb.net/mac-os-%E4%BD%BF%E7%94%A8-shadowsock-%E6%9D%A5%E4%BB%A3%E7%90%86-ssh-%E8%AE%BF%E9%97%AE%E6%9C%8D%E5%8A%A1%E5%99%A8/)
