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

- `PEAR` PHP Extension and Application Repository，PHP 官方开源类库，`pear list` 列出已经安装的包，`pear install` 安装需要的包。
- `PECL` PHP 扩展库，可以通过 PEAR 的 Package Manager 的管理方式来下载和安装扩展。
- php-config 输出 PHP 编译信息的辅助命令。
- phpdbg 轻量级调试平台。
- phpize 命令用来动态安装扩展。

GDB 调试 PHP 7。

## PHP 5.6

```bash
==> Caveats
To enable PHP in Apache add the following to httpd.conf and restart Apache:
    LoadModule php5_module /usr/local/opt/php@5.6/lib/httpd/modules/libphp5.so

    <FilesMatch \.php$>
        SetHandler application/x-httpd-php
    </FilesMatch>

Finally, check DirectoryIndex includes index.php
    DirectoryIndex index.php index.html

The php.ini and php-fpm.ini file can be found in:
    /usr/local/etc/php/5.6/

php@5.6 is keg-only, which means it was not symlinked into /usr/local,
because this is an alternate version of another formula.

If you need to have php@5.6 first in your PATH run:
  echo 'set -g fish_user_paths "/usr/local/opt/php@5.6/bin" $fish_user_paths' >> ~/.config/fish/config.fish
  echo 'set -g fish_user_paths "/usr/local/opt/php@5.6/sbin" $fish_user_paths' >> ~/.config/fish/config.fish

For compilers to find php@5.6 you may need to set:
  set -gx LDFLAGS "-L/usr/local/opt/php@5.6/lib"
  set -gx CPPFLAGS "-I/usr/local/opt/php@5.6/include"


To have launchd start exolnet/deprecated/php@5.6 now and restart at login:
  brew services start exolnet/deprecated/php@5.6
Or, if you don't want/need a background service you can just run:
  php-fpm
==> Summary
🍺  /usr/local/Cellar/php@5.6/5.6.40: 498 files, 60.5MB
```
