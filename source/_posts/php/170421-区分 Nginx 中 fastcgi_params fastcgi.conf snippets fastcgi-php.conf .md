---
title: 区分 Nginx 中 fastcgi_params fastcgi.conf snippets/fastcgi-php.conf
permalink: what-is-fastcgi-params-fastcgi-conf-snippets-fastcgi-php-conf
date: 2017-04-21 12:00:00
comments: true
toc: true
tags:
  - nginx
description:
---

Nginx 有两份 fastcgi 配置文件，分别是 `fastcgi_params` 和 `fastcgi.conf`，其区别只有一点点。到目前为止，由于 package managers，他们仍然引起新用户的混淆。

在自己系统中还有份 `snippets/fastcgi-php.conf`，这个又是啥？

## fastcgi_params vs fastcgi.conf

它们没有太大的差异，唯一的区别是 `fastcgi.conf` 比 `fastcgi_params` 多了一行 `SCRIPT_FILENAME` 的定义

```
fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
```

注意：`$document_root` 和 `$fastcgi_script_name` 之间没有 `/`。

原本 Nginx 只有 `fastcgi_params`，后来发现很多人在定义 `SCRIPT_FILENAME` 时使用了硬编码的方式，于是为了规范用法便引入了 `fastcgi.conf`

不过这样的话就产生一个疑问：为什么一定要引入一个新的配置文件，而不是修改旧的配置文件？

这是因为`fastcgi_param` 指令是数组型的，和普通指令相同的是：内层替换外层；和普通指令不同的是：当在同级多次使用的时候，是新增而不是替换。

换句话说，如果在同级定义两次 `SCRIPT_FILENAME`，那么它们都会被发送到后端，这可能会导致一些潜在的问题，为了避免此类情况，便引入了一个新的配置文件。

<!--more -->

### 实例

```
server {
    listen 80;
    server_name foo.com;

    root /path;
    index index.html index.htm index.php;

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

    location ~ \.php$ {
        try_files $uri =404;

        include fastcgi.conf;
        fastcgi_pass 127.0.0.1:9000;
    }
}
```

## snippets/fastcgi-php.conf

`/etc/nginx/snippets`: This directory contains configuration fragments that can be included elsewhere in the Nginx configuration. Potentially repeatable configuration segments are good candidates for refactoring into snippets.

`fastcgi-php.conf`:

```
# regex to split $uri to $fastcgi_script_name and $fastcgi_path
fastcgi_split_path_info ^(.+\.php)(/.+)$;

# Check that the PHP script exists before passing it
try_files $fastcgi_script_name =404;

# Bypass the fact that try_files resets $fastcgi_path_info
# see: http://trac.nginx.org/nginx/ticket/321
set $path_info $fastcgi_path_info;
fastcgi_param PATH_INFO $path_info;

fastcgi_index index.php;
include fastcgi.conf;
```

从 `fastcgi-php.conf` 的内容可以看出，它帮我们封装了一些公共代码

### 实例

```
server {
	...
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass 127.0.0.1:9000;
    }
}
```

## 让我把话说完

### PHP Nginx Unix sock 切换 TCP/IP

```
sudo vim /etc/php5/fpm/pool.d/www.conf
```

```
# 取消注释
listen.backlog = 65536
# 查找
listen = /var/run/php5-fpm.sock
# 修改为
listen = 127.0.0.1:9000
```

and then, edit Nginx configuration file

```
fastcgi_pass unix:/var/run/php5-fpm.sock;
# 修改为
fastcgi_pass 127.0.0.1:9000;
```

```
sudo service php5-fpm restart
sudo service nginx restart
```

> Reference:
>
> - [如何正确配置 Nginx+PHP | 火丁笔记](https://huoding.com/2013/10/23/290)
> - [fastcgi_params Versus fastcgi.conf - Nginx Config History](http://blog.martinfjordvald.com/2013/04/nginx-config-history-fastcgi_params-versus-fastcgi-conf/)
> - [How To Install Nginx on Ubuntu 16.04 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-16-04)
> - [nginx-build/fastcgi-php.conf at master · EasyEngine/nginx-build](https://github.com/EasyEngine/nginx-build/blob/master/nginx/debian/conf/snippets/fastcgi-php.conf)
