---
title: CentOS yum 升级 git 版本
permalink: centos-upgrade-git-by-yum
date: 2019-11-25 15:36:16
updated: 2019-12-04 12:04:56
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

## 使用 IUS

RHEL/CentOS 7

```bash
yum install \
https://repo.ius.io/ius-release-el7.rpm \
https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```

安装新版 git：

ius 通常会在高版本的软件名后面 + 'u'

```bash
yum list git git\*u
```

如果你已经装有低版本的 git，你需要先 remove（否则安装的时候会报错）

```bash
yum remove git
```

安装 2.0 以上版本的 git

```bash
yum install git2u
```

## WANdisco

另一个源：[WANdisco Replication Binaries](http://docs.wandisco.com/git/binaries/)

```bash
sudo vi /etc/yum.repos.d/wandisco-git.repo
```

wandisco-git.repo

```txt
[wandisco-git]
name=Wandisco GIT Repository
baseurl=http://opensource.wandisco.com/centos/7/git/$basearch/
enabled=1
gpgcheck=1
gpgkey=http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco
```

Import the repository GPG keys with:

```bash
sudo rpm --import http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco
```

```bash
sudo yum remove git

sudo yum install git
git --version
```

## References

- [How To Install Git on CentOS 7 | linuxize](https://linuxize.com/post/how-to-install-git-on-centos-7/)
- [How to install latest version of git on CentOS 7.x/6.x | stackoverflow](https://stackoverflow.com/questions/21820715/how-to-install-latest-version-of-git-on-centos-7-x-6-x)

-- EOF --
