---
title: Ubuntu下连接蓝牙键盘
permalink: ubuntu-bluetooth-keyboard
comments: true
date: 2016-06-14 13:48:00
tags: ubuntu
---

新买了Filco Majestouch Convertible 2键盘。在自己的笔记本上连接没什么问题，搬到公司Ubuntu的IBM笔记本这么都连接不上，上网查找解决。
<!-- more -->
>转自 [番茄博客-ubuntu下蓝牙键盘无法连接](http://www.thecatcher.net/archives/61f)

安装蓝牙的hcidump：
```
sudo apt-get install bluez-hcidump
```
然后
```
sudo hcidump -at
```
监测蓝牙事件。

再次连接蓝牙键盘，可以看到输出事件中有一条“Pin ...”
键盘输入对应的Pin，Enter，连接成功。
