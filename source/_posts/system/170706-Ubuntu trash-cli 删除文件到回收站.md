---
title: Ubuntu trash-cli 删除文件到回收站
permalink: trash-cli-move-files-to-trash
date: 2017-07-06 14:00:00
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

[andreafrancia/trash-cli: Command line interface to the freedesktop.org trashcan.](https://github.com/andreafrancia/trash-cli)

## Installation

```bash
easy_install trash-cli
```

<!-- more -->

## Usage

```bash
trash-put           trash files and directories.
trash-empty         empty the trashcan(s).
trash-list          list trashed files.
trash-restore       restore a trashed file.
trash-rm            remove individual files from the trashcan.
```

## FAQ

### Can I alias rm to trash-put?

在不少网站上看到：建议将 `trash-put` 命令通过别名的方式代替 `rm`

```bash
alias rm="trush-put"
```

但是作者说：

> Although rhe interface of trash-put seems to be compatible with rm, it has different semantics which will cause you problems. For example, while rm requires -R for deleting directories trash-put does not.

所以就使用 `trush` 来删除文件/文件夹到回收站

### But sometimes I forget to use trash-put, really can't I?

可以通过建立 `rm` 的 alias 提醒你不要使用它：

```bash
alias rm='echo "This is not the command you are looking for."; false'
```

如果你真的想使用 `rm`，只需先加一个斜线来绕过 alias：

```bash
\rm file-without-hope
```

注意：bash alias 仅在交互式 shell 中使用，因此使用 alias 不影响脚本中使用的 rm 命令。
