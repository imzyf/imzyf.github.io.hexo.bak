---
title: PHP 修改 memory_limit 内存限制
permalink: php-modify-memory-limit
date: 2017-04-11 11:00:00
comments: true
toc: true
tags:
   - php
description:
---
&emsp;&emsp;在进行大量统计运算时，PHP 可能产生内存不足的情况
<!-- more -->
## 查看 memory_limit
``` php
<?php phpinfo(); ?>
```

## 修改 memory_limit
&emsp;&emsp;可以在 `phpinfo()` 中找到 `Loaded Configuration File` `php.ini` 的位置
&emsp;&emsp;修改 `php.ini` 中的 memory_limit
``` ini
memory_limit = 1024M;
```
&emsp;&emsp;如果没有，你可以在文件的尾部自己增加这个参数

> reference:
> - [如何修改PHP的memory_limit限制 - 站长之家](http://www.chinaz.com/program/2011/1010/213048.shtml)
