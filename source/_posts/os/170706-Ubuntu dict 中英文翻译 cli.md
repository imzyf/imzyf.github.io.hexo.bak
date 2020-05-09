---
title: Ubuntu dict 中英文翻译 cli
permalink: chinese-and-english-translation-tools-cli
date: 2017-07-06 11:00:00
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

[FeeiCN/dict: 命令行下中英文翻译工具（Chinese and English translation tools in the command line）](https://github.com/FeeiCN/dict)

## Installation

```bash
sudo pip install dict-cli
```

<!-- more -->

## Usage

### English To Chinese

```bash
$ dict I love you

###################################
#  I love you 我爱你
#
#
#  我爱你。
# ...
###################################
```

### Chinese To English

```bash
$ dict 测试

###################################
#  测试 test
#  (Pinyin: cè shì)
#
#  [试验] test
#  measurement
#
#  测试 : Test
#...
###################################
```

-- EOF --
