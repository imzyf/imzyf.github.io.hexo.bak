---
title: Ubuntu 命令行下免密码执行 sudo 命令
permalink: execute-sudo-without-password-in-ubuntu-terminal
date: 2017-04-10 15:00:00
comments: true
toc: true
tags:
   - ubuntu
   - sudo
description:
---

The approach to solve your problem is to put your user in sudoers file.
<!--more -->
Open terminal window and type:
``` bash
sudo visudo
```
In the bottom of the file, type the follow:
```
username ALL=(ALL) NOPASSWD: ALL
```

Note:
This only applies, to sudo command in terminal window. For example, when you try to install a package in software center, you will be prompted to insert your password

> Reference:
> - [command line - Execute sudo without Password? - Ask Ubuntu](http://askubuntu.com/questions/147241/execute-sudo-without-password)
