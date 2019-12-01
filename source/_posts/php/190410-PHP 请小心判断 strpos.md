---
title: PHP 请小心判断 strpos
permalink: php-strpos-warning
date: 2019-04-10 20:27:21
updated:
tags:
  - php
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

有开始写世界上最后的语言 PHP 了（狗头保命）。一个很简单的字符串是否包含判断就掉坑了。

方法签名：

```php
strpos ( string $haystack , mixed $needle [, int $offset = 0 ] ) : int
```

<!-- more -->

```php
$mystring = 'abc';
$findme   = 'a';
if (strpos($mystring, $findme)) {
   dump('yes');
}
```

注意这时是不会输出 `yes`，因为 `strpos($mystring, $findme)` 返回的是 `0`。就想官方文档说的：

> Warning 此函数可能返回布尔值 FALSE，但也可能返回等同于 FALSE 的非布尔值。应使用 === 运算符来测试此函数的返回值。

正解：

```php
if (strpos($mystring, $findme) !== false) {
   dump('yes');
}
```

这次问题是网上一搜，找到 `strpos` 后看到 `如果没找到 needle，将返回 FALSE` 就没多想就用了。语言间的差异还有注意。

> Reference:
>
> - [php.net - strpos](https://www.php.net/manual/zh/function.strpos.php)

-- EOF --
