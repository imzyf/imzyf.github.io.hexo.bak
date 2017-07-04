---
title: Ubuntu 下安装 PHP 与常见问题
permalink: install-php-in-ubuntu-and-faq
date: 2017-07-04 17:00:00
comments: true
toc: true
tags:
   - php
   - ubuntu
description:
---
使用了很久的 PHP，但是如何在 Ubuntu 下正确的安装 PHP 总是不清不白。本篇文章就是汇总、积累安装 PHP 和安装时遇到的常见问题。

## Ubuntu 16.04 安装 php5.6
``` bash
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install -y php5.6
```

## 切换命令行中 PHP 版本
使用 `update-alternatives` 命令切换命令行中 PHP 版本
``` bash
sudo update-alternatives --config php
```
``` bash
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
``` bash
sudo apt-get purge php5.6-fpm
sudo apt-get install php5.6-fpm
```
其他扩展没有 `.ini` 文件或者配置文件被误删除时，可以使用相同的方法，`purge` 后 `install`

## php5.6 常用扩展安装
``` bash
sudo apt-get install php5.6 php5.6-cgi php5.6-cli php5.6-common php5.6-curl php5.6-dev php5.6-gd php5.6-json php5.6-mbstring php5.6-mcrypt php5.6-readline php5.6-soap php5.6-xml php5.6-xmlrpc php5.6-xsl php5.6-zip
```
清理所有
``` bash
sudo apt-get purge php5.6 php5.6-cgi php5.6-cli php5.6-common php5.6-curl php5.6-dev php5.6-gd php5.6-json php5.6-mbstring php5.6-mcrypt php5.6-readline php5.6-soap php5.6-xml php5.6-xmlrpc php5.6-xsl php5.6-zip
```

<!-- more -->

> Reference:
> - [How to Install PHP 5.6 on Ubuntu 16.04 / 14.04 using PPA](https://tecadmin.net/install-php5-on-ubuntu/)
> - [php - I deleted /etc/php5. How do I restore the folder? - Ask Ubuntu](https://askubuntu.com/questions/365750/i-deleted-etc-php5-how-do-i-restore-the-folder)
