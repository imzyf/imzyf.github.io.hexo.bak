---
title: 解决 Ubuntu warning Setting locale failed
permalink: resolving-ubuntu-warning-setting-locale-failed
date: 2017-03-03 17:00:00
comments: true
toc: true
tags: 
   - ubuntu
description: 
---

&emsp;&emsp;在配置新服务器时遇到 `Setting locale failed` 的警告，要求 `Please check that your locale settings`
<!-- more -->
```
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
    LANGUAGE = (unset),
    LC_ALL = (unset),
    LC_MESSAGES = "zh_CN.UTF-8",
    LANG = "zh_CN.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
```
## 解决方法
### 安装 localepurge 管理语言文件
```
sudo apt-get install localepurge
```
选择我们想要的语言，例如 `en_US.UTF-8` 和 `zh_CN.UTF-8`
当然也可以使用以下命令再次进行配置：
```
sudo dpkg-reconfigure localepurge
```
### 生成自己想要的语言
```
sudo locale-gen zh_CN.UTF-8 en_US.UTF-8
```
打印出当前的配置信息
````
locale
```

默认情况下终端 ssh 的时候会将本地的 locale 传到服务器中，可以通过命令指定 ssh 服务器的语言：
```
LC_ALL=en_US.UTF-8 ssh <host>
```

> Reference:
> - [ubuntu 解决语言设置错误的问题 —— 文翼的博客](http://wenzhixin.net.cn/2014/01/11/ubuntu_setting_locale_failed)
