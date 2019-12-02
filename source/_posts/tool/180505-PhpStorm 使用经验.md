---
title: PhpStorm 使用经验
permalink: phpstorm-using-experience
date: 2018-05-05 14:00:00
updated: 2019-11-26 11:33:49
tags:
  - phpstorm
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

## 修改主题

`Plugin` -> `Browse repositories` -> `Material Theme UI`

## Preferences

设置选择了一个词后，再按单引号或双引号，将选中的单词用引号括起来：

`Preferences` 中搜索 `Surround Selection on typing quote or brace` 将其勾选。

<!-- more -->

## 文件类型错误

一个文件被新建后，明明扩展名没有错，但是却没有语法高亮，删除文件后也不解决问题。

解决办法：`Editor` -> `File Types` 找 `Text` 将里面涉及的文件删除掉。

> - [phpstorm 文件类型错误](https://segmentfault.com/q/1010000004495692)

## Undefined function XXX

出现 PHP 的原生方法未定义的警告。

解决方法：File -> Invalidate Caches / Restart

## Typo: In word XXX

提示单词拼写错误，但是其中没有问题，比如全拼的名字。

解决方法：option + enter -> Save to dictionary

> - [Spellchecking | jetbrains](https://www.jetbrains.com/help/phpstorm/spellchecking.html)

## References

- [打造漂亮的 PhpStorm 界面](https://laravel-china.org/articles/4172/create-beautiful-phpstorm-interface)
- [大牛们的 PHPstorm 使用技巧和建议](http://www.pilishen.com/posts/phpstorm-tips-and-tricks)
