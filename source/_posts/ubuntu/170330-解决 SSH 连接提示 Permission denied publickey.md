---
title: 解决 SSH 连接提示 Permission denied publickey
permalink: resolving-ssh-permission-denied-publickey
date: 2017-03-30 17:00:00
comments: true
toc: true
tags:
   - ubuntu
   - ssh
description:
---
&emsp;&emsp;服务器是使用 publickey 进行连接，当在 git push 时发生 `Permission denied (publickey)`；同时解决 ssh-add 重启后失效
<!--more -->
## 解决
``` bash
ssh-add your_publickey
```
&emsp;&emsp;**注意：** 在重启电脑后失效，一直没有找的其他合适的解决方案，所以选择在 `~/.bashrc` 或 `~/.zshrc` 中添加：
``` bash
ssh-add your_publickey 2> /dev/null
```
&emsp;&emsp;`2> /dev/null` 是为了保持静默运行

> Reference:
> - [ssh 连接提示 Permission denied (publickey) 怎么破？ | 吴川斌的博客](http://www.mr-wu.cn/ssh-permission-denied-publickey/)
