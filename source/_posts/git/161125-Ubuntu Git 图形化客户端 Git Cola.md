---
title: Ubuntu Git 图形化客户端 Git Cola
permalink: git-client-gui-in-ubuntu-git-cola
date: 2016-11-25 15:00:00
updated:
tags:
  - git
  - ubuntu
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

Git Cola 是一个 Ubuntu 下的 Git 图形化客户端。在不熟悉 Git 命令时和在进行代码比对的情况下，可以很方便协助完成操作。

<!-- more -->

## Install Git Cola

```bash
sudo apt-get install git-core git-cola
```

## 使用 Git Cola

在桌面搜索栏中输入：`cola`，点打开软件。点击 `Open..` 选择 `git` 项目路径

可以在 `Branch`-> `Visualize Current Branch` 查看当前的 `branch`。目前的 branch 会以 `gitk` 视图显示

`Status` 视图中显示文件的状态，`Diff` 可方便查看文件的变动

## 一点经验

当发现 `Status` 面板中的内容没有刷新时，可以 `ctrl + r` 进行刷新

下面的这篇文章介绍的很好，就不再累述了：

- [圖解 Git 版本控制: Cola Git GUI (1)](http://graphicalgit.blogspot.com/2012/07/git-cola-git-gui-1.html)
