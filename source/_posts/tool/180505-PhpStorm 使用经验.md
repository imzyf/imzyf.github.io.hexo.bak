---
title: PhpStorm 使用经验
permalink: phpstorm-using-experience
date: 2018-05-05 14:00:00
updated: 2019-11-25 18:19:30
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

## Undefined function XXX

出现 PHP 的原生方法未定义的警告。

解决方法：File -> Invalidate Caches / Restart

## References

- [打造漂亮的 PhpStorm 界面](https://laravel-china.org/articles/4172/create-beautiful-phpstorm-interface)
- [大牛们的 PHPstorm 使用技巧和建议](http://www.pilishen.com/posts/phpstorm-tips-and-tricks)
- [phpstorm 文件类型错误](https://segmentfault.com/q/1010000004495692)
