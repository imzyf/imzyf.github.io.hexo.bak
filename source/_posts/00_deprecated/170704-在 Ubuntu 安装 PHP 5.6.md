---
title: 在 Ubuntu 安装 PHP 5.6
permalink: install-php-56-on-ubuntu
date: 2017-07-04 17:00:00
updated: 2020-04-28 17:32:51
tags:
  - php
  - ubuntu
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1552846697-d2ea93825b7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=640&q=80
feature_img:
---

2020-04-28 更新：很久没有用 Ubuntu & PHP 5.6，此文章内容不确定是否已失效。

---

使用了很久的 PHP，但是如何在 Ubuntu 下正确的安装 PHP 总是不清不白。本篇文章就是汇总、积累安装 PHP 和安装时遇到的常见问题。

<!-- more -->

## 环境

- Ubuntu 16.04

## 安装 PHP 5.6

```bash
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y php5.6
```

## 切换命令行中 PHP 版本

使用 `update-alternatives` 命令切换命令行中 PHP 版本

```bash
sudo update-alternatives --config php
```

```bash
There are 2 choices for the alternative php (providing /usr/bin/php).

  Selection    Path             Priority   Status
------------------------------------------------------------
  0            /usr/bin/php7.1   71        auto mode
* 1            /usr/bin/php5.6   56        manual mode
  2            /usr/bin/php7.1   71        manual mode

Press <enter> to keep the current choice[*], or type selection number: 1
```

## 配置文件没有生成

Not replacing deleted config file /etc/php/5.6/fpm/php.ini

```bash
sudo apt-get purge php5.6-fpm
sudo apt-get install php5.6-fpm
```

其他扩展没有 `.ini` 文件或者配置文件被误删除时，可以使用相同的方法，`purge` 后 `install`

## PHP 5.6 常用扩展安装

```bash
sudo apt-get install php5.6 php5.6-cgi php5.6-cli php5.6-common php5.6-curl php5.6-dev php5.6-fpm php5.6-gd php5.6-json php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-readline php5.6-soap php5.6-xml php5.6-xmlrpc php5.6-xsl php5.6-zip
```

清理所有

```bash
sudo apt-get purge php5.6 php5.6-cgi php5.6-cli php5.6-common php5.6-curl php5.6-dev php5.6-fpm php5.6-gd php5.6-json php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-readline php5.6-soap php5.6-xml php5.6-xmlrpc php5.6-xsl php5.6-zip
```

## References

- [How to Install PHP 5.6 on Ubuntu 16.04 / 14.04 using PPA | tecadmin](https://tecadmin.net/install-php5-on-ubuntu/)
- [php - I deleted /etc/php5. How do I restore the folder? | askubuntu](https://askubuntu.com/questions/365750/i-deleted-etc-php5-how-do-i-restore-the-folder)
