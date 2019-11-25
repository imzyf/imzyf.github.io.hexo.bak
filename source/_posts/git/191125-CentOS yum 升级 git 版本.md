---
title: CentOS yum 升级 git 版本
permalink: centos-upgrade-git-by-yum
date: 2019-11-25 15:36:16
updated:
tags:
  - git
  - centos
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1556075798-4825dfaaf498?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=480&q=70
feature_img:
---

先去官网看看 [Download for Linux and Unix](https://git-scm.com/download/linux):

```txt
RHEL and derivatives typically ship older versions of git. You can download a tarball and build from source, or use a 3rd-party repository such as the [IUS Community Project](https://ius.io/) to obtain a more recent version of git.
```

<!-- more -->

RHEL 和衍生通常提供较老版本的 git。您可以下载 tarball 并从源代码构建，或者使用第三方存储库，如 [IUS Community Project](https://ius.io/) 来获得最新版本的 git。

## 安装 IUS

RHEL/CentOS 7

```bash
yum install \
https://repo.ius.io/ius-release-el7.rpm \
https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```

## 安装新版 git

ius 通常会在高版本的软件名后面 + 'u'

```bash
yum list git git\*u
```

如果你已经装有低版本的 git，你需要先 remove (否则安装的时候会报错)

```bash
yum remove git
```

安装 2.0 以上版本的 git

```bash
yum install git2u
```

## References

- [ius 第三方源推荐—— 在 centos 上用 yum 安装最新的包 | jiebaby](http://jiebaby.com/index.php/archives/42/)
