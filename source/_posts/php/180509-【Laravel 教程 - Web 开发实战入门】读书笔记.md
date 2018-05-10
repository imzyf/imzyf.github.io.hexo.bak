---
title: 【Laravel 教程 - Web 开发实战入门】读书笔记
permalink: laravel-essential-training-reading-notes
date: 2018-05-09 17:00:00
updated: 2018-05-08 17:00:00
comments: true
toc: true
tags:
   - php
categories:
description:
---

[Laravel 教程 - Web 开发实战入门](https://laravel-china.org/courses?rf=10678) 读书笔记。

## 基础信息

### Laravel 与 PHP

Ruby on Rails 有以下原则：

- 强调与注重敏捷开发；
- 约定高于配置（Convention over configuration）；
- DRY（Don't repeat yourself）不要重复自己，提倡代码重用；
- 重视「编码愉悦性」。

### 如何正确阅读本书？

随后你会有很多机会来学习它们。现在最重要的是保持『训练』的连贯性。

编程是技能，不是知识，技能只有在不断刻意练习下才会有进步。

<!-- more -->

## 开发环境布置

### 第一个应用

```
$ composer create-project laravel/laravel Laravel --prefer-dist "5.5.*"
```

### Git 与 GitHub

设置 push 的默认模式为 simple

```
$ git config --global push.default simple
```

### 部署上线

注册 Heroku 后：

```bash
$ heroku login

# 添加 SSH Key 到 Heroku 上
$ heroku keys:add


# 创建配置文件来告诉 Heroku 应当使用什么命令来启动 Web 服务器
$ echo web: vendor/bin/heroku-php-apache2 public/ > Procfile
$ git add -A
$ git commit -m "Procfile for Heroku"

# 创建一个新应用
$ heroku create

# 对应用名称进行更改，保证未被其它人占用
$ heroku rename imzyf-laravel-essential

# 声明应用是用 PHP 写的
$ heroku buildpacks:set heroku/php

# 设置 APP key
$ php artisan key:generate
$ heroku config:set APP_KEY=base64:wuWj8Kicza6I9YxgWczviNVcueVN2RroqiUILreyNmA=

# 部署上线
$ git push heroku master

# 快速打开线上应用
$ heroku open

# 输出生产环境上的日志
$ heroku logs
```

## 构建页面

### 静态页面

生成静态页面控制器：

```
$ php artisan make:controller StaticPagesController
```

## 页面优化

### 样式美化

```
# 升级 yarn
$ brew  upgrade yarn

$ yarn install --no-bin-links
$ yarn add cross-env
```

每次检测到 `.scss` 文件发生更改时，自动将其编译为 `.css` 文件：

```
$ npm run watch-poll
```

### Laravel 前端工作流

Laravel Mix 一款前端任务自动化管理工具。Mix 提供了简洁流畅的 API，让你能够为你的 Laravel 应用定义 Webpack 编译任务。

`_header.blade.php` 为局部视图增加前缀下划线是『约定俗成』的做法。

### 布局中的链接

```
<li><a href="/help">帮助</a></li>

// 可以改写为

<li><a href="{{ route('help') }}">帮助</a></li>
```

路由中修改：

```
Route::get('/help', 'StaticPagesController@help')->name('help');
```

`route('help')` 将被渲染为 `http://sample.test/help`。

##
