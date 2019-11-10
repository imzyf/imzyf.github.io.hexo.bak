---
title: 区分 CGI FastCGI PHP-CGI PHP-FPM
permalink: what-is-cgi-fastcgi-phpcgi-phpfpm
date: 2017-04-21 11:00:00
comments: true
toc: true
tags:
  - php
description:
---

CGI FastCGI PHP-CGI PHP-FPM 一直区分不清，Google 后总结下

## CGI

CGI: Common Gateway Interface. HTTP 服务器与你的或其它机器上的程序进行“交谈”的一种协议，其程序须运行在网络服务器上。

web server（比如说 Nginx）只是内容的分发者。

- 如果请求 /index.html，那么 web server 会去文件系统中找到这个文件，发送给浏览器，这里分发的是静态数据。
- 如果现在请求的是 /index.php，根据配置文件，nginx 知道这个不是静态文件，需要去找 PHP 解析器来处理，那么他会把这个请求简单处理后交给 PHP 解析器。Nginx 会传哪些数据给 PHP 解析器呢？url、查询字符串、POST 数据、HTTP header 等等，CGI 就是规定要传哪些数据、以什么样的格式传递给后方处理这个请求的协议。

<!--more -->

## FastCGI

FastCGI 是 CGI 的升级版，一种语言无关的协议，用来沟通程序（如 PHP Python Java）和 Web 服务器（Apache2 Nginx），理论上任何语言编写的程序都可以通过 FastCGI 来提供 Web 服务。

FastCGI 的特点是会在一个进程中依次完成多个请求，以达到提高效率的目的，多数 FastCGI 实现都会维护一个进程池。

那么 CGI 程序的性能问题在哪呢？“PHP 解析器会解析 php.ini 文件，初始化执行环境”，就是这里了。标准的 CGI 对每个请求都会执行这些步骤，所以处理每个请求的时间会比较长。

那么 FastCGI 是怎么做的呢？首先，FastCGI 会先启一个 master，解析配置文件，初始化执行环境，然后再启动多个 worker。当请求过来时，master 会传递给一个 worker，然后立即可以接受下一个请求。这样就避免了重复的劳动，效率自然是高。而且当 worker 不够用时，master 可以根据配置预先启动几个 worker 等着；当然空闲 worker 太多时，也会停掉一些，这样就提高了性能，也节约了资源。这就是 FastCGI 对进程的管理。

## PHP-CGI

PHP-CGI 只是个 CGI 程序，他自己本身只能解析请求，返回结果，不会进程管理。

PHP-CGI 的不足：PHP-CGI 变更 php.ini 配置后需重启 PHP-CGI 才能让新的 php-ini 生效，不可以平滑重启。直接杀死 PHP-CGI 进程，PHP 就不能运行了。（PHP-FPM 和 Spawn-FCGI 就没有这个问题，守护进程会平滑从新生成新的子进程。）

## PHP-FPM

PHP 的解释器是 php-cgi，它只是个 CGI 程序，只能解析请求，返回结果，不会进程管理。所以就出现了一些能够调度 PHP-CGI 进程的程序。

PHP-FPM 是 PHP 针对 FastCGI 协议的具体实现，也是 PHP 在多种服务器端应用编程端口（SAPI：cgi、fast-cgi、cli、isapi、apache）里使用最普遍、性能最佳的一款进程管理器。

PHP 5.3.3 已经集成 PHP-FPM 了，不再是第三方的包了。PHP-FPM 提供了更好的 PHP 进程管理方式，可以有效控制内存和进程、可以平滑重载 PHP 配置，被 PHP 官方收录了。

## 小故事

你（PHP）去和爱斯基摩人（web 服务器，如 Apache、Nginx）谈生意。你说中文（PHP 代码），他说爱斯基摩语（C 代码），互相听不懂，怎么办？那就都把各自说的话转换成英语（FastCGI 协议）吧。

怎么转换呢？你就要使用一个翻译机（PHP-FPM）（当然对方也有一个翻译机，那个是他自带的）

我们这个翻译机是最新型的，老式的那个（PHP-CGI）被淘汰了。

## 让我把话说完

FastCGI 是 Nginx 和 PHP 之间的一个通信接口，该接口实际处理过程通过启动 PHP-FPM 进程来解析 PHP 脚本，即 PHP-FPM 相当于一个动态应用服务器，从而实现 Nginx 动态解析 PHP。

因此，如果 Nginx 服务器需要支持 PHP 解析，需要在 nginx.conf 中增加 PHP 的配置：将 PHP 脚本转发到 FastCGI 进程监听的 IP 地址和端口（php-fpm.conf 中指定）。

同时，PHP 安装的时候，需要开启支持 FastCGI 选项，并且编译安装 PHP-FPM 补丁/扩展，同时，需要启动 PHP-FPM 进程，才可以解析 Nginx 通过 FastCGI 转发过来的 PHP 脚本

> Reference:
>
> - [搞不清 FastCgi 与 PHP-fpm 之间是个什么样的关系](https://segmentfault.com/q/1010000000256516)
> - [什么是 CGI、FastCGI、PHP-CGI、PHP-FPM、Spawn-FCGI？](http://www.mike.org.cn/articles/what-is-cgi-fastcgi-php-fpm-spawn-fcgi/)
> - [nginx、fastCGI、php-fpm 关系梳理 842864681 新浪博客](http://blog.sina.com.cn/s/blog_6df9fbe30102v57y.html)
