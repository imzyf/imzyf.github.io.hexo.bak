---
title: 【Laravel 教程 - Web 开发实战入门】读书笔记
permalink: laravel-essential-training-reading-notes
date: 2018-05-09 17:00:00
updated: 2018-05-16 14:00:00
tags:
  - php
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

[Laravel 教程 - Web 开发实战入门](https://laravel-china.org/courses?rf=10678) 读书笔记。

## 基础信息

### Laravel 与 PHP

`Ruby on Rails` 有以下原则：

- 强调与注重敏捷开发；
- 约定高于配置（Convention over configuration）；
- DRY（Don't repeat yourself）不要重复自己，提倡代码重用；
- 重视「编码愉悦性」。

### 如何正确阅读本书

随后你会有很多机会来学习它们。现在最重要的是保持『训练』的连贯性。

编程是技能，不是知识，技能只有在不断刻意练习下才会有进步。

<!-- more -->

## 开发环境布置

### 第一个应用

```bash
$ composer create-project laravel/laravel Laravel --prefer-dist "5.5.*"
```

### Git 与 GitHub

设置 push 的默认模式为 simple

```bash
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

```bash
$ php artisan make:controller StaticPagesController
```

## 页面优化

### 样式美化

```bash
# 升级 yarn
$ brew  upgrade yarn

$ yarn install --no-bin-links
$ yarn add cross-env
```

每次检测到 `.scss` 文件发生更改时，自动将其编译为 `.css` 文件：

```bash
$ npm run watch-poll
```

### Laravel 前端工作流

Laravel Mix 一款前端任务自动化管理工具。Mix 提供了简洁流畅的 API，让你能够为你的 Laravel 应用定义 Webpack 编译任务。

`_header.blade.php` 为局部视图增加前缀下划线是『约定俗成』的做法。

### 布局中的链接

```bash
<li><a href="/help">帮助</a></li>

// 可以改写为

<li><a href="{{ route('help') }}">帮助</a></li>
```

路由中修改：

```bash
Route::get('/help', 'StaticPagesController@help')->name('help');
```

`route('help')` 将被渲染为 `http://sample.test/help`。

## 用户模型

### 数据库迁移

- 当我们运行迁移时，`up` 方法会被调用
- 当我们回滚迁移时，`down` 方法会被调用

### 查看数据库表

```bash
$ php artisan migrate

# 回滚
$ php artisan migrate:rollback
```

### 模型文件

创建模型命令指定命名空间，同时顺便创建数据库迁移使用 `--migration` 或 `-m` 选项

```
$ php artisan make:model Models/Article -m
```

『约定优于配置』（convention over configuration），也称作按约定编程，这是一种软件设计范式，旨在减少软件开发人员需做决定的数量，获得简单的好处，而又不失灵活性。如果所用工具的约定与你的期待相符，便可省去配置；反之，你可以配置来达到你所期待的方式。

### 创建用户对象

```
$ php artisan tinker

>>> App\Models\User::create(['name'=> 'Aufree', 'email'=>'aufree@yousails.com','password'=>bcrypt('password')])
```

## 用户注册

### 显示用户的信息

Laravel 遵从 RESTful 架构的设计原则，将数据看做一个资源，由 URI 来指定资源。

```
Route::resource('users', 'UsersController');

上面代码将等同于：

Route::get('/users', 'UsersController@index')->name('users.index');
Route::get('/users/{user}', 'UsersController@show')->name('users.show');
Route::get('/users/create', 'UsersController@create')->name('users.create');
Route::post('/users', 'UsersController@store')->name('users.store');
Route::get('/users/{user}/edit', 'UsersController@edit')->name('users.edit');
Route::patch('/users/{user}', 'UsersController@update')->name('users.update');
Route::delete('/users/{user}', 'UsersController@destroy')->name('users.destroy');
```

### 注册表单

全局辅助函数 old 来帮助我们在 Blade 模板中显示旧输入数据

```
{{ old('name') }}
```

### 用户数据验证

为了安全考虑，会让我们提供一个 token（令牌）来防止我们的应用受到 CSRF（跨站请求伪造）的攻击。

```
{{ csrf_field() }}
```

会被转换为：

```
<input type="hidden" name="_token" value="fhcxqT67dNowMoWsAHGGPJOAWJn8x5R5ctSwZrAq">
```

### 注册失败错误消息

```
$ composer require "overtrue/laravel-lang:~3.0"
```

`config/app.php` 修改：

```
    'locale' => 'zh-CN',
```

### 注册成功

临时保存用户数据的方法 - 会话（Session），并附带支持多种会话后端驱动，可通过统一的 API 进行使用。

```
session()->flash('success', '欢迎，您将在这里开启一段新的旅程~');

session()->get('success')
```

## 会话管理

### 用户登录

`Auth::check()` 方法用于判断当前用户是否已登录，已登录返回 true，未登录返回 false。

### 记住我

`Auth::attempt()` 方法可接收两个参数，第一个参数为需要进行用户身份认证的数组，第二个参数为是否为用户开启『记住我』功能的布尔值。

## 用户 CRUD

### 更新用户

```
<form method="POST" action="{{ route('users.update', $user->id )}}">

// 将转为：

<form method="POST" action="http://sample.test/users/1">
```

### 权限系统

在 Laravel 中可以使用 授权策略 (Policy) 来对用户的操作权限进行验证，在用户未经授权进行操作时将返回 403 禁止访问的异常。

`redirect()` 实例提供了一个 intended 方法，该方法可将页面重定向到上一次请求尝试访问的页面上，并接收一个默认跳转地址参数，当上一次请求记录为空时，跳转到默认地址上。

```
return redirect()->intended(route('users.show', [Auth::user()]));
```

### 列出所有用户

假数据的生成分为两个阶段：

1. 对要生成假数据的模型指定字段进行赋值 - 『模型工厂』
2. 批量生成假数据模型 - 『数据填充』

数据库的重置和填充操作：

```
$ php artisan migrate:refresh --seed
```

## 邮件发送

### 账户激活

1. 用户注册成功后，自动生成激活令牌
1. 将激活令牌以链接的形式附带在注册邮件里面，并将邮件发送到用户的注册邮箱上
1. 用户点击注册链接跳到指定路由，路由收到激活令牌参数后映射给相关控制器动作处理
1. 控制器拿到激活令牌并进行验证，验证通过后对该用户进行激活，并将其激活状态设置为已激活
1. 用户激活成功，自动登录

使用 log 邮件驱动的方式来调试邮件发送功能，这么做的好处是邮件并不会真正被发送出去，而是会出现在 `storage/logs/laravel.log` 文件中：

```
MAIL_DRIVER=log
```

### 在生产环境中发送邮件

QQ 邮箱的账号设置里开启 `POP3` 和 `SMTP` 服务。

```
MAIL_DRIVER=smtp
MAIL_HOST=smtp.qq.com
MAIL_PORT=25
MAIL_USERNAME=xxxxxxxxxxxxxx@qq.com
MAIL_PASSWORD=xxxxxxxxx // 密码是我们第一步拿到的授权码
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=xxxxxxxxxxxxxx@qq.com
MAIL_FROM_NAME=SampleApp
```

## 微博 CRUD

### 显示微博

`diffForHumans()` 该方法的作用是将日期进行友好化处理：

```
>>> $created_at->diffForHumans()
=> "17 years ago"
```
