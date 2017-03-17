---
title: 解决 Ubuntu Sogou 无法选词输入中文
permalink: resolving-ubuntu-sogou-can-not-select-word
date: 2017-03-17 17:00:00
comments: true
toc: true
tags: 
   - ubuntu
   - sogou
description: 
---
&emsp;&emsp; sogou 输入法突然无法选词输入中文，候选词位置出现白框，多次重重装 fcitx 和 sogou 也没有解决。尝试使用 google pinyin 代替，但是感觉很不顺手
<!--more -->
## issue in GitHub
&emsp;&emsp; sogou 输入法 GitHub 上的一些 issue：
- [#43](https://github.com/FZUG/repo/issues/43)
- [#177](https://github.com/FZUG/repo/issues/177)
- [#179](https://github.com/FZUG/repo/issues/179)

## 解决
### 方案一
try to lastest version
### 方案二
clean `fcitx`, `SogouPY*`, `sogou-qimpanel` in `~/.config`, then relogin and try again

> Reference:
> - [ubuntu-sogou-不能显示候选词 | Color Win's Notes](https://colorwin.github.io/2017/02/17/ubuntu-sogou/)

