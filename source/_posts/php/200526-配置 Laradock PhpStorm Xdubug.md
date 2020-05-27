---
title: 配置 Laradock PhpStorm Xdubug
permalink: config-laradock-phpstorm-xdubug
date: 2020-05-26 09:45:15
updated:
tags:
  - php
  - phpstorm
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1584451609541-4aa1974359fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=640&q=80
feature_img:
---

最近在学习 Yii2 的源码，为了方便调试所以研究下 Laradock + PhpStorm + Xdubug 的配置。

## 环境

- macOS
- Laradock v10.0

请保证 Laradock 是最新的版本，可以减少不必要的麻烦。也推荐使用我精简过的项目 [imzyf/my-dock | github](https://github.com/imzyf/my-dock)。

<!-- more -->

## 配置 Laradock

```bash
vim .env

WORKSPACE_INSTALL_XDEBUG=true
PHP_FPM_INSTALL_XDEBUG=true
```

重新编译 php-fpm 和 workspace 容器：

```bash
docker-compose build php-fpm workspace
```

## 配置 PhpStorm

### 配置 Docker

Preferences > Build, Execution, Deploymnent > Docker

![docker](https://user-images.githubusercontent.com/9289792/82999144-302d2100-a03b-11ea-8a21-08bc67838fc2.png)

### 配置 PHP

Preferences > Languages & Frameworks > PHP，PHP CLI Interpreter 点 `...`

![php 1](https://user-images.githubusercontent.com/9289792/82997395-e7746880-a038-11ea-98ca-d68052d5bd22.png)

点击 +，选择 From Docker, Vagrant...

![php 2](https://user-images.githubusercontent.com/9289792/82997724-55209480-a039-11ea-8235-4a0479aeb832.png)

Debugger 可以显示出 Xdebug。

### 配置 Servers

Preferences > Languages & Frameworks > PHP > Servers

![server](https://user-images.githubusercontent.com/9289792/82998171-f7d91300-a039-11ea-89e7-50b79664b0f6.png)

注意：Name 必须填写 Laradock 中的 PHP_IDE_CONFIG 也就就是 `laradock`。

### 配置 Xdebug

Preferences > Languages & Frameworks > PHP > Debug。点击 `Validate`，填写。

![Xdebug](https://user-images.githubusercontent.com/9289792/82998451-530b0580-a03a-11ea-925a-1770df95eb66.png)

run > Edit Configurations，添加 PHP Remote Debug。IDE key 为 `PHPSTORM`。

![Xdebug2](https://user-images.githubusercontent.com/9289792/82998663-95ccdd80-a03a-11ea-9dc4-5d00d012e7df.png)

## 配置 Chrome

下载插件 [Xdebug helper](https://chrome.google.com/webstore/detail/eadndfjplgieldjbigjakmdgkmoaaaoc)，右键图标 配置。

![chrome](https://user-images.githubusercontent.com/9289792/82998865-d3316b00-a03a-11ea-94cc-a6642fa0cdbf.png)

## enjoy

![start](https://user-images.githubusercontent.com/9289792/82999306-636fb000-a03b-11ea-9c0f-a059fbc47fd3.png)

开启 debug，然后访问页面。

![fly](https://user-images.githubusercontent.com/9289792/82999463-96b23f00-a03b-11ea-922a-4c91169628a9.png)

芜湖起飞。

## References

- [Laradock 使用 PhpStorm Debug 代码 | learnku](https://learnku.com/articles/24389)
- [Set Debugger Using Xdebug With PHPStorm & Laradock | medium](https://medium.com/@chenpohsun_12588/set-debugger-using-xdebug-with-phpstorm-laradock-454e8c2ad0d9)

-- EOF --
