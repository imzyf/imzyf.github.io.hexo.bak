---
title: PHP Call to undefined function ftp_ssl_connect
permalink: php-call-to-undefined-function-ftp-ssl-connect
date: 2020-05-08 17:17:46
updated:
tags:
  - php
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1535488518105-67f15b7cab27?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=640&q=80
feature_img:
---

## 环境

- CentOS 7.4
- PHP 7.1.12 编译安装

<!-- more -->

## 复现

```bash
/usr/local/php71/bin/php -r "ftp_ssl_connect('server1.example.com');"

PHP Fatal error:  Uncaught Error: Call to undefined function ftp_ssl_connect() in Command line code:1
```

## 原因

看文档：[ftp_ssl_connect | php.net](https://www.php.net/ftp_ssl_connect)

1. ftp 扩展没配置
2. opensll 没有启用

## 解决方案

```bash
# /root/php-7.1.12/ is php source dir
cd /root/php-7.1.12/ext/ftp/

# /usr/local/php71/ is php dir
/usr/local/php71/bin/phpize

# the param --with-openssl-dir is very important
./configure --with-php-config=/usr/local/php71/bin/php-config --with-openssl-dir

make
make install

vim /usr/local/php71/lib/php.ini
# add last line
extension=ftp.so

service php-fpm reload
```

这要注意一定要加上 `--with-openssl-dir`，不然会 `FTPS support => disabled`。

当不清楚 `./configure` 有什么参数时，可以执行 `./configure --help`。

## 检查

```bash
# method 1
/usr/local/php71/bin/php -r "phpinfo();" | grep FTP

FTP support => enabled
FTPS support => enabled

# method 2
/usr/local/php71/bin/php -r "ftp_ssl_connect('server1.example.com');"

PHP Warning:  ftp_ssl_connect(): php_network_getaddresses: getaddrinfo failed: Name or service not known in Command line code on line 1
```

## References

- [Fatal error: Call to undefined function ftp_ssl_connect() | stackoverflow](https://stackoverflow.com/questions/35085677/fatal-error-call-to-undefined-function-ftp-ssl-connect/61683198#61683198)

-- EOF --
