---
title: PhpStorm 使用经验
permalink: phpstorm-using-experience
date: 2018-05-05 14:00:00
updated: 2020-04-28 17:55:17
tags:
  - php
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

<!-- more -->

## Preferences

设置选择了一个词后，再按单引号或双引号，将选中的单词用引号括起来：

`Preferences` 中搜索 `Surround Selection on typing quote or brace` 将其勾选。

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

## 使用 PHP-CS-Fixer

> [The PHP Coding Standards Fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer) (PHP CS Fixer) tool fixes your code to follow standards.

工作环境：MacBook。

打开 PhpStorm `Preferences > Tools > External Tools` 添加：

![180416-use-php-cs-fixer-in-phpstorm-001](https://user-images.githubusercontent.com/9289792/80202885-de1e6780-8658-11ea-904b-3ea7e393182c.png)

- Program: `/usr/local/bin/php-cs-fixer`
- Parameters: `--rules=@Symfony --verbose fix "$FileDir$/$FileName$"`（Note that previous verions of PHP-CS-Fixer used --levels instead of --rules. 未找到）
- Working directory: `$ProjectFileDir$`
- 我取消勾选了 Open console，可以不输出日志信息

设置快捷键 `Preferences > Keymap`：

![180416-use-php-cs-fixer-in-phpstorm-002](https://user-images.githubusercontent.com/9289792/80202900-e5de0c00-8658-11ea-826f-b4d058fa2209.png)

## References

- [打造漂亮的 PhpStorm 界面](https://laravel-china.org/articles/4172/create-beautiful-phpstorm-interface)
- [大牛们的 PHPstorm 使用技巧和建议](http://www.pilishen.com/posts/phpstorm-tips-and-tricks)
- [Use PHP-CS-Fixer in PHPStorm](https://gist.github.com/nienkedekker/3ddb9ece42233698c0e3f3e42cf1ff34)
