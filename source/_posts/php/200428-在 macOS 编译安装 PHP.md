---
title: 在 macOS 编译安装 PHP
permalink: make-install-php-on-macos
date: 2020-04-28 18:09:59
updated: 2020-04-29 11:37:55
tags:
  - php
  - mac
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1530520960548-0d70a1ad430d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=640&q=80
feature_img:
---

## 环境

- macOS 10.15.4
- PHP 5.6.40

<!-- more -->

## 下载 PHP

源码地址：https://www.php.net/releases/#5.6.40

```bash
cd /tmp
wget https://www.php.net/distributions/php-5.6.40.tar.gz --no-check-certificate
tar zxvf php-5.6.40.tar.gz
```

## 安装相关库

```bash
# libiconv
brew install libiconv

# openssl
brew install openssl

# zlib 实现 GZIP 压缩页面
brew install zlib
```

## 配置

> [核心配置选项列表 | php.net](https://www.php.net/manual/zh/configure.about.php)

```bash
# 查看配置参数
./configure --help
./configure --help | grep openssl

./configure --prefix=/usr/local/php56 --enable-fpm --enable-debug --enable-gd-native-ttf --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-openssl=(brew --prefix openssl) --enable-mbstring --with-zlib=(brew --prefix zlib) --enable-zip --with-iconv=(brew --prefix libiconv)
```

## 编译安装

```bash
# 4核编译
make -j4
make install
```

## 遇到的问题

### "\_libiconv", referenced from

```bash
Undefined symbols for architecture x86_64:
  "_libiconv", referenced from:
      _php_iconv_string in iconv.o
      __php_iconv_strlen in iconv.o
      __php_iconv_substr in iconv.o
      __php_iconv_strpos in iconv.o
      __php_iconv_mime_encode in iconv.o
      __php_iconv_appendl in iconv.o
      _php_iconv_stream_filter_append_bucket in iconv.o
      ...
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [sapi/cli/php] Error 1
```

解决方法：打开 Makefile 找到 `EXTRA_LDFALGS` `EXTRA_LDFLAGS_PROGRAMS` 删除后面的 `-L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib`

```bash
vim Makefile

EXTRA_LDFLAGS = -L/usr/local/opt/openssl/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/libiconv/lib
EXTRA_LDFLAGS_PROGRAM = -L/usr/local/opt/openssl/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/libiconv/lib
```

```bash
make clean && make -j4
```

### Please specify the install prefix of iconv with --with-iconv=\<DIR\>

```bash
brew install libiconv
```

### Cannot find OpenSSL's

> configure: error: Cannot find OpenSSL's `<evp.h>`

```bash
brew install openssl
```

```bash
./configure --with-openssl-dir=(brew --prefix openssl)
```

## References

- [Mac Pro 编译安装 PHP 5.6.21 及 问题汇总 | cnblogs](https://www.cnblogs.com/52php/p/5683356.html)

-- EOF --
