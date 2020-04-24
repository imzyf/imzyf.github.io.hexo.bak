---
title: 【PHP 7 底层设计与源码实现】笔记
permalink: php-7-internals-reading-notes
date: 2019-07-30 16:24:49
updated: 2019-07-30 16:24:49
comments: true
toc: true
tags:
  - php
categories:
description:
---

## PHP 7 概况

### 1.1 新特性

1. 太空舱操作符 `<=>`
2. 标量类型声明、返回值的类型声明

- `string` `int` `float` `bool`
- 默认模式下尝试类型转换，严格模式下直接报错
- 可空类型 `?int`

3. null 合并操作符 `??`
4. 常量数组
5. namespace 批量导入 `use Space\{ClassA, ClassB, ClassC as C};`
6. 全局的 throwable 接口
7. Closure::call()
8. intdiv 函数
9. list 的方括号写法

### PHP 7 安装和编译

[PHP Download](https://www.php.net/downloads.php) 下载 7.1.\*。

```
$ cd php-7.1.30
$ ./configure --prefix=$HOME/php/php-7.1.30/output --enable-fpm --enable-debug
```

遇到一个问题：

```
PHP Configure Error: Please specify the install prefix of iconv with --with-iconv=<DIR>
```

解决办法：

```
$ brew install libiconv

$ ./configure --prefix=$HOME/php/php-7.1.30/output --enable-fpm --enable-debug --with-iconv=$(brew --prefix libiconv)

./configure --with-openssl --enable-mbstring --enable-fpm --with-mysqli --with-pdo-mysql
```

yum groupinstall "Development tools"

./configure --prefix=/data/home/v_yfanzhao/php56 --with-openssl --enable-mbstring --enable-fpm --with-mysqli --with-pdo-mysql --enable-ftp

继续编译安装：

```
$ make && make install
$ cd output
$ ls

bin     etc     include lib     php     sbin    var

$ cd bin && ls

pear       peardev    pecl       phar       phar.phar  php        php-cgi    php-config phpdbg     phpize
```

可能的另一个报错：

```
Undefined symbols for architecture x86_64:
  "_libiconv", referenced from:
      _zif_iconv_substr in iconv.o
      _zif_iconv_mime_encode in iconv.o
      _php_iconv_string in iconv.o
...
```

解决方法：打开 Makefile 找到 `EXTRA_LDFALGS` `EXTRA_LDFLAGS_PROGRAMS` 删除 `L/Applications/Xcode.app...`

```
EXTRA_LDFLAGS = -L/usr/local/opt/libiconv/lib
EXTRA_LDFLAGS_PROGRAM = -L/usr/local/opt/libiconv/lib
```

- `PEAR` PHP Extension and Application Repository，PHP 官方开源类库，`pear list` 列出已经安装的包，`pear install` 安装需要的包。
- `PECL` PHP 扩展库，可以通过 PEAR 的 Package Manager 的管理方式来下载和安装扩展。
- php-config 输出 PHP 编译信息的辅助命令。
- phpdbg 轻量级调试平台。
- phpize 命令用来动态安装扩展。

GDB 调试 PHP 7。
