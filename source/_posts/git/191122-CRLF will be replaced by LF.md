---
title: CRLF will be replaced by LF
permalink: crlf-will-be-replaced-by-lf
date: 2019-11-22 17:30:37
updated: 2019-12-04 11:43:48
tags:
  - git
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1505409859467-3a796fd5798e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=640&q=80
feature_img:
---

```bash
$ git add .

warning: CRLF will be replaced by LF in X.
```

- CRLF：windows 环境下的换行符
- LF：linux 环境下的换行符

这个错误的意思，就是文件中存在两种环境的换行符，git 会自动替换 CRLF 为 LF ，所以提示警告。

<!-- more -->

首先推荐扩展阅读：[配置 Git 处理行结束符 | GitHub](https://help.github.com/cn/github/using-git/configuring-git-to-handle-line-endings)

我项目中是配置了 `.gitattributes` 的：

```txt
# Set the default behavior, in case people don't have core.autocrlf set.
* text=auto

# Explicitly declare text files you want to always be normalized and converted
# to native line endings on checkout.
*.c text
*.h text

# Declare files that will always have CRLF line endings on checkout.
*.sln text eol=crlf

# Denote all files that are truly binary and should not be modified.
*.png binary
*.jpg binary
```

## .gitattributes

公式：`要匹配的文件模式 属性1 属性2 ...`。

### 示例 1

```txt
* text=auto
```

对任何文件，设置 text=auto，表示文件的行尾自动转换。如果是文本文件，则在文件入 Git 库时，行尾自动转换为 LF。如果已经在入 Git 库中的文件的行尾为 CRLF，则该文件在入 Git 库时，不再转换为 LF。

### 示例 2

```txt
*.txt text
```

对于 txt 文件，标记为文本文件，并进行行尾规范化。

### 示例 3

```txt
*.jpg -text

*.jpg binary
```

对于 jpg 文件，标记为非文本文件，不进行任何的行尾转换。`*.jpg -text` 可能是旧版本的写法。

### 示例 4

```txt
*.vcproj text eol=crlf
```

对于 vcproj 文件，标记为文本文件，在文件入 Git 库时进行规范化，即行尾为 LF。但是在检出到工作目录时，行尾自动转换为 CRLF。

### 示例 5

```txt
*.sh text eol=lf
```

对于 sh 文件，标记为文本文件，在文件入 Git 库时进行规范化，即行尾为 LF。在检出到工作目录时，行尾也不会转换为 CRLF（即保持 LF）。

### 示例 6

```txt
*.py eol=lf
```

对于 py 文件，只针对工作目录中的文件，行尾为 LF。

## 还是有问题

在项目中已经添加 `.gitattributes` 文件，但是还是出现了报错，这时要检查 git 的版本。（CentOS 自带的 git 版本较低）

> 可以参考：[CentOS yum 升级 git 版本](https://zyf.im/2019/11/25/centos-upgrade-git-by-yum/)

后来还查到了一个方法，`.gitattributes`：

```txt
* -crlf
```

## References

- [Git 的 gitattributes 文件详解 | csdn](https://blog.csdn.net/taiyangdao/article/details/78484623)
- [gitattributes - Defining attributes per path | git-scm](https://git-scm.com/docs/gitattributes)
- [How to make Git ignore different line endings | rtuin](https://www.rtuin.nl/2013/02/how-to-make-git-ignore-different-line-endings/)

-- EOF --
