---
title: PHP Swoft 框架环境配置
permalink: deploy-swoft-framework
date: 2020-08-07 11:45:19
updated:
tags:
  - php
  - swoft
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1457364559154-aa2644600ebb?ixlib=rb-1.2.1&auto=format&fit=crop&w=640&q=80
feature_img:
---

## 安装 Swoole

```bash
pecl install swoole
```

可能出现：

```txt
Connection to `ssl://pecl.php.net:443′ failed:
```

```bash
# 检查
php -r "print_r(openssl_get_cert_locations());"

Array
(
    [default_cert_file] => /private/etc/ssl/cert.pem
    [default_cert_file_env] => SSL_CERT_FILE
    [default_cert_dir] => /private/etc/ssl/certs
    [default_cert_dir_env] => SSL_CERT_DIR
    [default_private_dir] => /private/etc/ssl/private
    [default_default_cert_area] => /private/etc/ssl
    [ini_cafile] =>
    [ini_capath] =>
)

ls /private/etc/ssl/
# 现没有 cert.pem 这个证书

# 下载证书
wget -c https://curl.haxx.se/ca/cacert.pem /private/etc/ssl/cert.pem --no-check-certificate

# 再次执行
pecl install swoole
```

## PEAR PECL Composer

[PEAR](http://pear.php.net/)：PHP Extension and Application Repository，PEAR 将 PHP 程序开发过程中常用的功能编写成类库，涵盖了页面呈现、数据库访问、文件操作、数据结构、缓存操作、网络协议、WebService 等许多方面，用户可以通过下载这些类库并适当的作一些定制以实现自己需要的功能。避免重复发明“车轮”。PEAR 的出现大大提高了 PHP 程序的开发效率和开发质量。使用的时候，要在代码中进行 Include 才能够使用。但基本已经没落，被 Composer 取而代之。

[PECL](https://pecl.php.net/)：PHP Extension Community Library，是使用 C 语言开发的，通常用于补充一些用 PHP 难以完成的底层功能，往往需要重新编译或者在配置文件中设置后才能在用户自己的代码中使用。相对来说是比较底层的扩展。PECL 是 PEAR 的一部分。

官网说明：https://pecl.php.net/

eg：安装 Reids 扩展 https://pecl.php.net/package/redis

```bash
pecl install redis
```

Composer：PHP 的包管理工具，优点在于仅需要提供一个 composer.json 文件，申明需要用到的三方库，一个简单的命令就能将其依赖全部装好。

目前，我们使用 Composer 来管理 PHP 代码包，使用 PECL 来管理 C 扩展。

## References

- [关于 PHP 的扩展 PECL、PEAR、Composer | su520](http://itman.su520.com/2017/08/23/pecl-%E5%92%8C-pear-%E6%9C%89%E4%BB%80%E4%B9%88%E5%8C%BA%E5%88%AB%EF%BC%9F/)

-- EOF --
