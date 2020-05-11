---
title: PHP float 精度
permalink: php-float-precision
date: 2020-05-09 17:32:34
updated: 2020-05-11 14:07:34
tags:
  - php
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1517728848779-e95acb6ac40f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=640&q=80
feature_img:
---

## 实例 1

```php
$a = 1.1;
echo gettype($a);
echo "\n";
var_dump($a);
```

输出结果：

```bash
double
float(1.1)
```

## 实例 2

```php
$a = "123456789.1100110011";
$a = (float) $a;
var_dump($a);
var_dump(sprintf('%.11f', $a));

$b = 123456789.11001;
var_dump($b);
var_dump(sprintf('%.11f', $b));

$c = '123456789.1100110011';
$c = (float) $c;
$c = (string) $c;
$c = (float) $c;
var_dump($c);
var_dump(sprintf('%.11f', $c));


var_dump($a === $b);
var_dump($b === $c);
```

输出结果：

```bash
float(123456789.11001)
string(21) "123456789.11001099646"
float(123456789.11001)
string(21) "123456789.11000999808"
float(123456789.11001)
string(21) "123456789.11000999808"
bool(false)
bool(true)
```

## 实例 3

```php
// # 1
var_dump(120085 === 1200.85 * 100);

// # 2
var_dump(120085 == 1200.85 * 100);

// # 3
var_dump(120081 == 1200.81 * 100);

// # 4
var_dump(120085 - 1200.85 * 100);
```

输出结果：

```bash
bool(false)
bool(false)
bool(true)
float(1.4551915228367E-11)
```

## 实例 4

```php
$a = 0.1;
$b = 0.9;
$c = 1;

var_dump(($a + $b) == $c);
var_dump(($c - $b) == $a);

var_dump(sprintf('%.20f', $a + $b));
var_dump(sprintf('%.20f', $c - $b));
```

输出结果：

```bash
bool(true)
bool(false)
string(22) "1.00000000000000000000"
string(22) "0.09999999999999997780"
```

## 分析

看文档：

- [gettype | php.net](https://www.php.net/manual/zh/function.gettype.php)
- [Float 浮点型 | php.net](https://www.php.net/manual/zh/language.types.float.php)

> 浮点型（也叫浮点数 float，双精度数 double 或实数 real）
> 浮点数的字长和平台相关，尽管通常最大值是 1.8e308 并具有 14 位十进制数字的精度（64 位 IEEE 格式）。
> 所以永远不要相信浮点数结果精确到了最后一位，也永远不要比较两个浮点数是否相等。如果确实需要更高的精度，应该使用任意精度数学函数或者 gmp 函数。

实例 1：说明在 PHP 中 `float` 与 `dobule` 是一回事。在 C 级别，所有内容都存储为 double。

实例 2、3：float 的比较结果是 _视情况而定_，**永远不要相信浮点数结果精确到了最后一位**。

实例 4：出现这个问题是因为浮点数计算涉及精度，当浮点数转为二进制时有可能会造成精度丢失。

## 浮点数转二进制方法

整数部分采用除以 2 取余方法，小数部分采用乘以 2 取整方法。

例如：把数字 8.5 转为二进制：

整数部分是 8：

- 8/2=4 8%2=0
- 4/2=2 4%2=0
- 2/2=1 2%2=0
- 1 比 2 小，因此不需要计算下去，整数 8 的二进制为 1000

小数部分是 0.5：

- 0.5x2 = 1.0
- 因取整后小数部分为 0，因此不需要再计算下去，小数 0.5 的二进制为 0.1

  8.5 的二进制为 1000.1。

计算数字 0.9 的二进制：

- 0.9x2 = 1.8
- 0.8x2 = 1.6
- 0.6x2 = 1.2
- 0.2x2 = 0.4
- 0.4x2 = 0.8
- 0.8x2 = 1.6
- ... 之后不断循环下去，当截取精度为 N 时，N 后的数会被舍去，导致精度丢失。

实例 4 中 0.9 在转为二进制时精度丢失，导致比较时出现错误。

> 你看似有穷的小数，在计算机的二进制表示里却是无穷的。

## float 比较方法

### 使用 round 方法处理后再比较

```php
var_dump(120085 == round(1200.85 * 100));
// bool(true)

var_dump(12008.5 === round(1200.85 * 10, 1));
// bool(true)

var_dump(1200.85 === round(1200.8499999, 2));
// bool(true)
```

### 使用高精度运算方法

见文档 [BC 数学 函数 | php.net](https://www.php.net/manual/zh/ref.bc.php)。

## References

- [PHP 浮点型与整型比较的小坑 | codecasts](https://www.codecasts.com/blog/post/php-tricky-floats-comparison-with-int)
- [php 浮点数比较方法 | csdn](https://blog.csdn.net/fdipzone/article/details/48106065)
- [PHP 浮点数的一个常见问题的解答 | laruence](https://www.laruence.com/2013/03/26/2884.html)

-- EOF --
