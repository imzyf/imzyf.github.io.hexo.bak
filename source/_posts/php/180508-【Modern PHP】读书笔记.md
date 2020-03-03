---
title: 【Modern PHP】读书笔记
permalink: modern-php-reading-notes
date: 2018-05-08 17:00:00
updated: 2018-05-08 17:00:00
comments: true
toc: true
tags:
  - php
categories:
description:
---

又回到 PHP Web 开发，使用 Laravel 框架，重读《Modern PHP》。

> PHP 正在重生。

## 特性

### 命名空间

声明命名空间：

```php
<?php
namespace Oreilly\ModernPHP;
```

导入和别名：

```php
<?php
use Symfony\Component\HttpFoundation\Response as Res;

$r = new Res('Oops', 400);
$r->send();
```

<!-- more -->

PHP 5.6 开始可以导入函数和常量：

```
<?php
use func Namespace\functionName;
use constant Namespace\CONST_NAME;

functionName();
echo CONST_NAME;
```

### 使用接口

接口是两个 PHP 对象之间的契约，其目的不是让一个对象依赖另一个对象的身份，而是依赖另一个对象的能力。

使用接口编写更加灵活，能委托别人实现细节。

### 性状 trait

性状是类的部分实现，可以混入一个或者多个现有的 PHP 类中。性状有两个作用：表明类可以做什么（像是接口）；提供模块化实现（像是类）。

如果想让两个无关的 PHP 类具有类似的行为，应该怎么呢？性状就是为了解决这种问题而诞生的。性状能把模块化的实现方式注入多个无关的类中。而且性状还能促进代码的重用。

这与创建一个接口，两个无关的类实现这个接口的优势在于：不用写相同的实现代码，符合 DRY 原则。

PHP 解释器在编译时会把性状复制粘贴到类的定义体中，但是不会处理这个操作引入的不兼容问题。如果性状假定类中有特定的属性和方法（在性状中没有定义），要确保相应的类中有对应的属性和方法。

### 生成器

Generator 是 PHP 5.5.0 引入的功能。生成器是简单的迭代器，仅此而已。

PHP 生成器不要求类实现 Iterator 接口，从而减轻了类的负担。生成器会根据需求计算并产生要迭代的值。这对应该的性能有重大影响。假如标准的 PHP 迭代器经常在内存中执行迭代操作，这要预先计算出数据集，性能低；此时我们可以使用生成器，即时计算并产出后续值，不占用宝贵的内存资源。

PHP 生成器不能满足所有迭代操作的需求，因为如果不查询，生成器永远不知道下一个要迭代的值是什么，在生成器中无法后退和快进。生成器还是一次性，无法多次迭代同一个生成器。不过，如果需要，可以重建或克隆生成器。

PHP 生成器是 PHP 函数，只不过要在函数中一次或者多次使用 yield 关键字。生成器从不返回值，值产出值。

```
function myGenerator() {
    yield 'value1';
    yield 'value2';
    yield 'value3';
}

foreach (myGenerator()  as $yieldedValue) {
   echo $yieldedValue, PHP_EOL;
}

value1
value2
value3
```

使用生成器处理 CSV：

```
function getRows($file) {
    $handle = fopen($file, 'rb');
    if ($handle === false) {
        throw new Exception();
    }
    while (feof($handle) === false) {
        yield fgetcsv($handle);
    }
    fclose($handle);
}

foreach (getRows('data.csv') as $row) {
   print_r($row);
}
```

### 闭包

理论上讲，闭包和匿名函数是不同的概念。不过，PHP  将其视作相同的概念。

```
$closure = function ($name) {
    return sprintf('Hello %s', $name);
}

echo $closure("Josh");
```

我们之所以能调用 \$closure 变量，是因为这个变量的值是一个闭包，而且闭包对象实现了 `__invoke()` 魔术方法。只要变量名后有()，PHP 就会查找并调用 `__invoke()` 方法。

PHP 闭包常被当做函数和方法的回调使用。

```
$numbersPlusOne = array_map(function ($number) {
    return $number + 1;
}, [1,2,3]);

print_r($numbersPlusOne);

// [2,3,4]
```

在有闭包之前，只能单独创建具名函数，然后使用名称引用那个函数：

```
$numbersPlusOne = array_map('incrementNumber', [1,2,3]);
// 如果只需要使用一次回调，没必要单独定义。把闭包当成回调使用，写出的代码更整洁、更清晰。
```

使用 use 关键字附加闭包状态：

```
function enclosePerson($name) {
    return function ($doCommand) use ($name) {
        return sprintf('%s, %s', $name, $doCommand);
    }
}

// 把字符串 Clay 封装到闭包里
$clay = enclosePerson('Clay');

// 传入参数，调用闭包
echo $clay('get me sweet tea!');

// "Clay, get me sweet tea!"
```

具名函数 enclosePerson() 有个名为 $name 的参数，这个函数返回一个闭包对象，而且这个闭包封装了 $name 参数。即便返回的闭包对象跳出了 enclosePerson() 函数的作用域，它也会记住 $name 参数的值，因为 $name 变量仍在闭包中。

PHP 闭包是对象。闭包对象的默认状态没什么用，不过有一个 `__invoke()` 魔术方法和 `bindTo()` 方法。

### Zend OPcache

字节码缓存能存储预先编译好的 PHP 字节码。这意味着，请求 PHP 脚本时，PHP 解释器不用每次都读取、解析和编译 PHP 代码。

### 内置的 HTTP 服务器

启动这个服务器：

```
php -S localhost:4000

// 让 PHP Web 服务器监听所有接口
php -S 0.0.0.0:4000
```

## 标准

### PSR 是什么

PHP Standards Recommendation.

- PSR-1 基本的代码风格
- PSR-2 严格的代码风格
- PSR-3 日志记录器接口
- PSR-4 自动加载

## 组件

### 查找组件

- [Awesome PHP](https://github.com/ziadoz/awesome-php#text-editors-and-ides)
- [Packagist](https://packagist.org)

## 良好实践

### 流

流式数据的种类各异，每种类型需要独特的协议，以便读写数据。称这些协议为流封装协议。

1. 开始通信
2. 读取数据
3. 写入数据
4. 结束通信

指定协议和目标的方法是使用流标识符：

`<scheme>://<target>`

使用 HTTP 流封装协议创建了一个与 Flickr API 通信的 PHP 流：

```
<?php
$json = file_get_contents(
    'http://api.flickr.com/services/feeds/photos_public.gne?format=json'
);
```

不要误以为这是普通的网页 URL，file_get_contents() 函数的字符串参数其实是一个流标识符。http 协议会让 PHP 使用 HTTP 流封装协议。在这个参数中，http 之后是流的目标。很多 PHP 开发者不知道普通的 URL 其实是 PHP 流封装协议标识的伪装。

我们使用 file_get_contents() fopen() fwrite() 和 fclose() 函数读写文件系统。因为 PHP 默认使用的流封装协议是 file://，使用我们很少认为这些函数使用的是 PHP 流。

隐式使用 file:// 流封装协议：

```
$handle = fopen('/etc/hosts', 'rb');
while (feof($handle) !== ture) {
    echo fgets($handle);
}
fclose($handle);
```

显示使用 file:// 流封装协议：

```
...
$handle = fopen('file://etc/hosts', 'rb');
...
```

我们通常会省略 file:// 封装协议，这是 PHP 使用的默认值。

编写命令行脚本的 PHP 开发者会感激 php:// 流封装协议。这个流封装协议的作用是与 PHP 脚本的标准输入、标准输出和标准错误文件描描述符通信。

php://stdin 只读 PHP 流，其中的数据来自标准输入。例如，接收命令行传入脚本的信息。

php://stdout 把数据写入当前的缓冲区。这个流只能写，无法读或寻址。

php://memory 从系统内存中读取数据，或者把数据写入系统内存。缺点是，可用内存是有限的。使用 php://temp 流更安全。

php://temp 和 php://memory 类似，不过没有可以内存时，PHP 会把数据写入临时文件。

### 错误和异常

提到了 [Monolog](https://github.com/Seldaek/monolog) 记录日志。

## 调优

### 内存

_一共能分配给 PHP 多少内存？_

Linode 2GB 的 sever 留 512MB 给 PHP。

_单个 PHP 进程平均消耗多少内存？_

使用 top 命令查看。一般 PHP 进程消耗 5 ~ 20MB 内存。

_能负担的起多少个 PHP-FPM 进程？_

假设 PHP 分配了 512MB 内存，每个 PHP 平均消耗 15MB 内存，从而确定能负担的起 34 个进程。

压力测试工具：

- [ab - Apache HTTP server benchmarking tool](https://httpd.apache.org/docs/2.4/programs/ab.html)
- [Siege](https://www.joedog.org/siege-home/)

### Zend OPcache

```
opcache.memory_consumption = 64
# 为操作码缓存分配的内存量（单位 MB）。

opcache.interned_strings_buffer = 16
# 用来存储驻留字符串的内存量（单位 MB，默认 4MB）。

opcache.max_accelerated_file = 4000
# 操作码缓存中最多能存储多少个 PHP 脚本。这个值一定比 PHP 应用中的文件数量大。

opcache.validate_timestamps = 1
# 为 1 时，一段时间后 PHP 会检查 PHP 脚本的内容是否变化。检查的时间间隔由 revalidate_freq 指定。
# 开发环境设为 1，在生成环境中为 0。

opcache.revalidate_freq = 0
# 设置多久检查一次 PHP 脚本的内容是否有变化。

opcache.fast_shutdown = 1
# 这么设置能让操作码使用更快的停机步骤，把对象析构和内存释放交给 Zend Engine 的内存管理器完成。
```

### 文件上传

```
file_uploads = 1
upload_max_filesize = 10M
max_file_uploads = 3
```

如果需要上传非常大的文件，还要调整 nginx 虚拟主机配置中的 client_max_body_size 设置。

### 会话处理

```
session.save_handler = 'memcached'
session.save_path = '127.0.0.2:11211'
```

### 缓冲输出

```
output_buffering = 4096
implicit_flush = false
```

确保使用的值是 4（32 位系统）或者 8（64 位系统）的倍数。

### 真实路径缓存

realpath cache，PHP 会缓存应用使用的文件路径，这样每次包含或者导入文件时就无需不断搜索包含路径了。

```
realpath_cache_size = 64k
```

## 部署

提到了 [Capistrano](http://capistranorb.com/) 待研究。

## 测试

- PHPUnit
- Xdebug
- 使用 Travis CI 持续测试

## 分析

- XHProf 较新的 PHP 应用分析器
- XHGUI
- New Relic
- Blackfire

## HHVM 和 Hack

Hip-Hop Virtual Machine.

Hack 是一门建立在 PHP 之上的编程语音，引入了静态类型，新的数据结构和额外的接口，同时还能向后兼容现有的动态类型 PHP 代码。

动态类型和静态类型，二者之间的区别在于何时检查 PHP 类型。动态类型在运行时检查类型，而静态类型在编译时检查类型。

-- EOF --
