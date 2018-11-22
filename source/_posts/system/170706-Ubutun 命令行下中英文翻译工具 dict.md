---
title: Ubutun 命令行下中英文翻译工具 dict
permalink: chinese-and-english-translation-tools-in-the-command-line
date: 2017-07-06 11:00:00
comments: true
toc: true
tags:
   - ubuntu
   - awesome-linux
description:
---

[wufeifei/dict: 命令行下中英文翻译工具（Chinese and English translation tools in the command line）](https://github.com/wufeifei/dict)

## Installation

``` bash
sudo pip install dict-cli
```

<!-- more -->

## Usage

### English To Chinese

``` bash
$ dict test

###################################
#  test 测试
#  (U: tɛst E: test)
#
#  n. 试验；检验
#  vt. 试验；测试
#  vi. 试验；测试
#  n. (Test)人名；(英)特斯特
# ...
###################################

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

``` bash
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

$ dict 我爱你

###################################
#  我爱你 I love you
#  (Pinyin: wǒ ài nǐ)
#
#  I love you
#...
###################################
```
