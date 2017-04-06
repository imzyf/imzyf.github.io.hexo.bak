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
&emsp;&emsp;服务器是使用 publickey 进行连接，当在 git push 时发生 `Permission denied (publickey)`
<!--more -->
## 解决
```
ssh-add your_publickey
```

> Reference:
> - [ssh 连接提示 Permission denied (publickey) 怎么破？ | 吴川斌的博客](http://www.mr-wu.cn/ssh-permission-denied-publickey/)
