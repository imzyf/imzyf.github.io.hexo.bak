---
title: Git clean 从工作区中删除未跟踪的文件
permalink: git-clean-remove-untracked-files-from-the-working-tree
date: 2017-02-22 14:00:00
updated:
tags:
  - git
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

从当前目录开始，通过递归删除不在版本控制之下的文件来清除工作树。

## Manual

使用 `man` 命令，是一个很好的查看命令使用的方法

```bash
man git clean
```

## SYNOPSIS 概要

```bash
git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
```

## OPTIONS

- `-d` 删除未跟踪的目录和未跟踪的文件。如果一个未跟踪的目录是另一个不同的 Git 库，默认将不会把它删除。如果你想删除这个目录，可以使用 `-f`
- `-f` , `--force` 如果 Git 配置中 `clean.requireForce` 没有设置为 `false`，git clean 将拒绝执行。除非是使用 `-f` `-n` `-i`
- `-i` , `--interactive` 使用交互式显示将被删除的文件
- `-n` , `--dry-run` 仅仅显示将被删除的文件，不会真正的删除
- `-q` , `--quiet` 静默，仅仅显示错误，不包括成功移除的文件
- `-e <pattern>` , `--exclude=<pattern>` 除了在 `.gitignore`（每个目录）和 `$GIT_DIR/info/exclude`，也要考虑这些模式设置的忽略规则
- `-x` 不使用 `.gitignore`（每个目录）和 `$GIT_DIR/info/exclude` 的标准忽略规则，但仍然使用使用 `-e` 选项给出的忽略规则。这允许删除所有未跟踪的文件，包括构建产品。 这可以使用（可能与 git reset）以创建一个原始的工作目录来测试一个干净的构建
- `-X` 只删除 Git 忽略的文件。这可能有助于从头重建一切，但保留手动创建的文件

<!-- more -->

## 常用操作

通过以上几根参数组合，基本上可以满足删除未跟踪文件的需求了

1、例如在删除前先查看有哪些文件将被删除运行：

```
git clean -n
```

2、想删除当前工作目录下的未跟踪文件，但不删除文件夹运行（如果 `clean.requireForce` 为 `false` 可以不加 `-f` 选项）：

```
git clean -f
```

3、想删除当前工作目录下的未跟踪文件以及文件夹运行：

```
git clean -df
```

> Reference:
>
> - [Git 清除未跟踪文件 - GLGJing&#8217;s Blog](http://glgjing.github.io/blog/2015/01/09/git-qing-chu-wei-gen-zong-wen-jian/)
