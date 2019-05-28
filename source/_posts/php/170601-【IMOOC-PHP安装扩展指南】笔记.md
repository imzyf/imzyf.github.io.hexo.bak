---
title: 【IMOOC-PHP安装扩展指南】笔记
permalink: imooc-install-php-extension-guide-notes
date: 2017-06-01 12:00:00
updated: 2017-06-01 12:00:00
comments: true
toc: true
tags:
   - php
categories:
description:
---

## PHP 扩展简介

### 优点

- 快速扩展功能
- 按需加载，节省资源

### 常见扩展

- MySQL - 操作 MySQL 功能
- GD2 - 动态常见图片
- Xdebug - 跟踪、调试、分析 PHP 程序运行情况

<!-- more -->

### PHP 运行

1. Zend 引擎初始化
2. Extensions
3. SAPI - ServerApplicationApi 中间组
4. 上层应用

### PHP 扩展运行

1. Extensions
   1.2 初始化 - 内部变量、分配资源、注册资源句柄、注册 Zend 函数
2. SAPI 请求初始化
3. 执行
4. 关闭 - 回收资源

### 查看扩展

- 使用 `phpinfo()` 探针
- `get_loaded_extensions()` - 返回了 PHP 解释器里所有编译并加载的模块名 - array
- `extension_loaded()` 检查一个扩展是否已经加载

### 管理扩展

- 扩展目录：对应 php.ini 中 `extension_dir`
- 开启扩展：php.ini 添加 `extension="绝对路径"`

## Windows 下安装 PHP 扩展

### 流程

1. 下载扩展
2. 选择版本
3. 解压到对应目录
4. php.ini 中开启扩展，配置扩展相关参数
5. 重启服务器

### 扩展文件名

`.dll` 的文件

### PECL

- [The PHP Extension Community Library](http://pecl.php.net)
- 针对 Windows [windows.php.net/downloads/pecl/releases](http://windows.php.net/downloads/pecl/releases/)

### 选择版本

phpinfo 中 `PHP Extension Build` 可以查看 PHP 版本信息。PHP 版本、VC 版本、nts/ts、x64/x86 要都对应

### Windows 下安装 redis 扩展

- 下载 [php_redis.dll](http://windows.php.net/downloads/pecl/releases/redis/2.2.8/logs/) 放入扩展目录
- php.ini 添加 `extension=php_redis.dll`
- 重启服务

## Linux 下安装 PHP 扩展

### 流程

1. 下载扩展 [The PHP Extension Community Library](http://pecl.php.net)
2. 选择版本 - 注意 Dependencies
3. 解压到扩展目录
4. php.ini 中开启扩展，配置扩展相关参数
5. 重启服务器

### 扩展文件名

`.so` 的文件

### 扩展文件

linux 的 PHP 扩展存放在安装目录下的 `lib/php/extensions` 下。

> Reference:
>
> - [imooc - PHP 扩展安装指南](https://www.imooc.com/learn/757)
