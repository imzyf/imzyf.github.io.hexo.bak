---
title: Atom 插件 php-cs-fixer 规范代码格式
permalink: atom-plugin-php-cs-fixer
date: 2017-06-13 17:00:00
comments: true
toc: true
tags:
   - atom
   - php
description:
---

良好的代码规范可以提高代码可读性，降低团队沟通维护成本。[PSR-1](https://laravel-china.org/topics/2078/psr-specification-psr-1-basic-coding-specification) [PSR-2](https://laravel-china.org/topics/2079/psr-specification-psr-2-coding-style-specification) 可以说是 PHP 代码规范之基

## Requirements
- This version requires the PHP-CS-Fixer >= v2.0.0!
- PHP needs to be a minimum version of PHP 5.6.0.

## Install PHP-CS-Fixer
[FriendsOfPHP/PHP-CS-Fixer: A tool to automatically fix PHP coding standards issues](https://github.com/FriendsOfPHP/PHP-CS-Fixer)

You can run these commands to easily access latest php-cs-fixer from anywhere on your system:
``` bash
wget http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -O php-cs-fixer
```
then:
``` bash
sudo chmod a+x php-cs-fixer
sudo mv php-cs-fixer /usr/local/bin/php-cs-fixer
```
Then, just run php-cs-fixer.

## Install php-cs-fixer Atom-Package
[php-cs-fixer Atom-Package](https://atom.io/packages/php-cs-fixer)

``` bash
apm install php-cs-fixer
```
或者直接在 Packages 中搜索安装

## Setting
You can configure php-cs-fixer from the Atom package manager or by editing `~/.atom/config.cson` (choose Open Your Config in Atom menu).

你也可以点击 Edit -> Config 找到对应的文件

Here's an example configuration:
```
  "php-cs-fixer":
    executablePath: "/usr/local/bin/php-cs-fixer"
    executeOnSave: true
    phpExecutablePath: "php7.1"
    rules: "@PSR1, @PSR2, @Symfony"
```

同样也可以在 Package 中编辑

勾选 `Execute on save` 将在保存时执行，很方便

## Notice
- PHP 版本要 5.6+
- PHP-CS-Fixer 版本要 2.0+
- 我系统 `php` 命令使用的是 5.5 的版本，所以在 `PHP executable path` 中填写高版本的 PHP 命令
