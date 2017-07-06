---
title: Ubutun 命令行下中英文翻译工具 dict
permalink: chinese-and-english-translation-tools-in-the-command-line
date: 2017-07-06 11:00:00
comments: true
toc: true
tags:
   - ubuntu
   - awesome-liunx
description:
---
[wufeifei/dict: 命令行下中英文翻译工具（Chinese and English translation tools in the command line）](https://github.com/wufeifei/dict)

## install
``` bash
sudo pip install dict-cli
```

## usage
### English To Chinese
``` bash
dict test
###################################
#  test 测试
#  (U: tɛst E: test)
#
#  n. 试验；检验
#  vt. 试验；测试
#  vi. 试验；测试
#  n. (Test)人名；(英)特斯特
#
#  Test : 测试
#          测验
#          检验
#  Test Drive : Test Drive
#                Test Drive
#                无限狂飙
#  Test Engineer : 测试员
#                   测试工程师
#                   软件测试工程师
###################################

dict I love you
###################################
#  I love you 我爱你
#
#
#  我爱你。
#
#  I love you : 我爱你
#                ILOVEYOU蠕虫
#                寻找伴郎
#  I really love you : 真的爱你
#                       其实很爱你
#                       我是真的爱你
#  I Do love you : 我是爱你的
#                   真的爱你
#                   爱你我该怎么办
###################################
```

### Chinese To English
``` bash
dict 测试
###################################
#  测试 test
#  (Pinyin: cè shì)
#
#  [试验] test
#  measurement
#
#  测试 : Test
#          test
#          TST test
#  集成测试 : Integration testing
#              Test d'intégration
#              통합 시험
#  ANOVA测试 : Gage R&amp;R
#             ANOVA gauge R&amp;R
###################################

dict 我爱你
###################################
#  我爱你 I love you
#  (Pinyin: wǒ ài nǐ)
#
#  I love you
#
#  我爱你 : I love you
#            Ich liebe dich
#            Wuh that I love you
#  我也爱你 : I Love You Too
#              And I Love You So
#              Ik ook van jou
#  我就爱你 : The Arrangement
#              gou couh gyaez mwngz muengh
#              I'll just be love you
###################################
```
