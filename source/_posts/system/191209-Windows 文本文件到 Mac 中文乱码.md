---
title: Windows 文本文件到 Mac 中文乱码
permalink: windows-text-file-to-mac-chinese-messy-code
date: 2019-12-09 14:45:39
updated:
tags:
  - mac
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1566699270403-3f7e3f340664?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=480&q=80
feature_img:
---

文本文件从 Windows 系统复制到 Mac 系统中文发生乱码，原因肯定是编码问题。

<!-- more -->

## 解决办法

[iconv | wikipedia](https://zh.wikipedia.org/wiki/Iconv) 它的作用是在多种国际编码格式之间进行文本内码的转换。

```bash
iconv [OPTION...] [-f ENCODING] [-t ENCODING] [INPUTFILE...]

iconv -f GB18030 -t utf-8 < infile.txt > outfile.txt
```

## Reference

- [文本文件从 Windows 拷贝到 Mac 乱码 | super2bai](https://super2bai.github.io/codec/w2m.html)

-- EOF --