---
title: PHP Code Snippet
permalink: php-code-snippet
date: 2020-04-15 18:03:44
updated: 2020-04-26 15:43:32
tags:
  - php
  - code-snippet
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1563752576703-4a6ab9a6206b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=640&q=80
feature_img:
---

## 交互式运行模式

```bash
php -a
```

交互式 shell 还具有函数、常量、类名、变量、静态方法调用和类常量的 `tab` 补全功能。

<!-- more -->

## 参数查看

### 查看 PHP 编译时的参数

```bash
php -r "phpinfo();" | grep configure
```

### 查看 .ini 配置文件路径

```bash
php --ini
```

```bash
php -r "phpinfo();" | grep "Configuration File"
```

### 查看 Modules

```bash
php -m
```

### Show configuration for extension

显示扩展配置。`--ri <name> Show configuration for extension <name>.`

```bash
php --ri gd
```

## 修改内存限制

修改 `php.ini` 中的 `memory_limit` 如果没有，可以在文件的尾部增加这个参数。

```ini
memory_limit = 1024M;
```

## 动态实例化类

```php
class Test1{
  public function __construct(){
    echo "Test1<br>";
  }
}

// 方法一
$class1 = "Test1";
new $class1();

// 方法二
$class2 = "Test2";
// 建立类的反射
$class2 = new ReflectionClass($class2);
// 相当于实例化类
$instance = $class2->newInstance();
```

## composer 常用

### aliyun repo

[阿里云 Composer 全量镜像](https://developer.aliyun.com/composer)

```bash
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
```

```bash
    "config": {
        "disable-tls": true,
        "secure-http": false,
        "gitlab-domains": [],
        "platform-check": "php-only",
        "optimize-autoloader": true,
        "sort-packages": true,
        "preferred-install": {
            "*": "dist"
        }
    },
    "repositories": [
        {
            "type": "composer",
            "url": "https://mirrors.aliyun.com/composer/"
        },
        {
            "type": "cvs",
            "url": "..."
        },
        {
            "type": "composer",
            "url": "https://asset-packagist.org"
        }
    ]
```

### 忽略 php 版本限制

这个是极不推荐的，这样会造成库安装的版本错误。**不应该使用。**

```bash
composer require hellogerard/jobby --ignore-platform-reqs
```

推荐：

```bash
which composer
# /usr/local/bin/composer

{正确的 PHP 版本}/bin/php /usr/local/bin/composer require hellogerard/jobby

/usr/local/opt/php@7.1/bin/php -d memory_limit=-1 /usr/local/bin/composer update -vvv
```

### emory-limit-errors for more info on how to handle out of memory errors

```bash
php -d memory_limit=-1 /usr/local/bin/composer update
```

### 更新 composer.lock

若项目之前已通过其他源安装，则需要更新 composer.lock 文件：

```bash
composer update --lock
```

## PHP.net

- [Supported Versions](https://www.php.net/supported-versions.php)
- [Unsupported Branches](https://www.php.net/eol.php)

## References

- [PHP: Interactive shell | php.net](http://php.net/manual/en/features.commandline.interactive.php)

-- EOF --
