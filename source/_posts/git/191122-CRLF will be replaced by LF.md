---
title: CRLF will be replaced by LF
permalink: crlf-will-be-replaced-by-lf
date: 2019-11-22 17:30:37
updated:
tags:
  - git
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1465378295786-5cb1fca555ff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=480&q=70
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

但是我项目中是配置了 `.gitattributes` 的：

```txt
* text=auto eol=lf
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
```

对于 jpg 文件，标记为非文本文件，不进行任何的行尾转换。

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

### 推荐配置

```text
* text=auto eol=lf
```

## 还是有问题

在项目中已经添加 `.gitattributes` 文件，但是还是出现了报错，这时要检查 git 的版本。（CentOS 自带的 git 版本较低）

## References

- [Git 的 gitattributes 文件详解 | csdn](https://blog.csdn.net/taiyangdao/article/details/78484623)
- [gitattributes - Defining attributes per path | git-scm](https://git-scm.com/docs/gitattributes)
