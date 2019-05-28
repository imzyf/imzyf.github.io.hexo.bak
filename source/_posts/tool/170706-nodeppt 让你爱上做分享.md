---
title: nodeppt 让你爱上做分享
permalink: nodeppt-make-you-fall-in-love-with-to-share
date: 2017-07-06 17:00:00
comments: true
toc: true
tags:
   - node-js
   - ubuntu
   - awesome
description:
---

[ksky521/nodeppt: This is probably the best web presentation tool so far!](https://github.com/ksky521/nodeppt)

## 安装

```bash
npm install -g nodeppt
```

## 创建

```bash
nodeppt create ppt-name
```

<!-- more -->

## 启动

```bash
# 获取帮助
nodeppt start -h
# 绑定端口
nodeppt start -p <port>
nodeppt start -p 8090 -d path/for/ppts
# 绑定host，默认绑定0.0.0.0
nodeppt start -p 8080 -d path/for/ppts -H 127.0.0.1
# 使用socket通信（按Q键显示/关闭二维码，手机扫描，即可控制）
# socket须知：1、注意手机和pc要可以相互访问，2、防火墙，3、ip
```

## 演示

有一个小坑的地方，如果你指定特别的端口，使用的则是默认的 `8080`，这时：

```bash
netstat -antpl | grep 8080
```

可以看到：

```bash
tcp        0      0 192.168.8.149:8080      0.0.0.0:*               LISTEN      4801/node
```

访问 `192.168.8.149:8080` 才可以，`localhost:8080` 不可以
