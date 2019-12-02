---
title: Ubuntu 命令行下免密码执行 sudo 命令
permalink: execute-sudo-without-password-in-ubuntu-terminal
date: 2017-04-10 15:00:00
updated:
tags:
  - ubuntu
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

解决你的问题的方法是将你的用户加入 sudoers 文件。

```bash
sudo visudo
```

在文件底部输入：

```
username ALL=(ALL) NOPASSWD: ALL
```

这只适用于终端窗口中的 sudo 命令。例如，当你尝试在 software center 中安装软件包时，将提示你输入密码。

<!--more -->

> Reference:
>
> - [command line - Execute sudo without Password? - Ask Ubuntu](http://askubuntu.com/questions/147241/execute-sudo-without-password)
