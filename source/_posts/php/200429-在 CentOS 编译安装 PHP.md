---
title: 在 CentOS 编译安装 PHP
permalink: make-install-php-on-centos
date: 2020-04-29 11:37:51
updated:
tags:
  - php
  - centos
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1515434327095-612c365d4738?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=640&q=80
feature_img:
---

## 环境

- CentOS 10.15.4
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
yum groupinstall "Development tools"
```

## 配置

> [核心配置选项列表 | php.net](https://www.php.net/manual/zh/configure.about.php)

```bash
# 查看配置参数
./configure --help
./configure --help | grep openssl

./configure --prefix=/usr/local/php56 --with-openssl --enable-mbstring --enable-ftp
```

## 编译安装

```bash
# 4核编译
make -j4
make install
```

-- EOF --
