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
服务器是使用 publickey 进行连接，当在 git push 时发生 `Permission denied (publickey)`；同时解决 ssh-add 重启后失效

## 解决
``` bash
ssh-add your_publickey
```
如果遇到报错
```
Could not open a connection to your authentication agent.
```
Try to
```
eval `ssh-agent`
```

**注意：** 在重启电脑后失效，一直没有找的其他合适的解决方案，所以选择在 `~/.bashrc` 或 `~/.zshrc` 中添加：
``` bash
ssh-add your_publickey 2> /dev/null
```
`2> /dev/null` 是为了保持静默运行

<!--more -->

> Reference:
> - [ssh 连接提示 Permission denied (publickey) 怎么破？ | 吴川斌的博客](http://www.mr-wu.cn/ssh-permission-denied-publickey/)
