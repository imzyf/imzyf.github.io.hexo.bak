---
title: PHP empty 方法判断 0.0
permalink: php-empty-method-judge-0
date: 2017-03-09 17:00:00
comments: true
toc: true
tags: 
   - php
description: 
---
&emsp;&emsp;在使用 `empty(mixed $var)` 时要考虑 `$var` 的**类型**，尤其是在判断数据库查询后的字段
<!-- more -->
```
bool empty(mixed $var) 
```

&emsp;&emsp;以下的东西被认为是空的：
- `""`（空字符串）
- `0` （作为整数的0）
- `0.0` （作为浮点数的0）
- `"0"` （作为字符串的0）
- `NULL`
- `FALSE`
- `array()` （一个空数组）
- `$var` （一个声明了，但是没有值的变量）

&emsp;&emsp;**注意：**string 的判断要非常注意，数据库查询后的字段常常为 string；应该进行正确的类型转换
``` php
$str = '0.0';
echo empty($str); // false 很可能和预期是相反的
echo empty((float)$str); // true
```
