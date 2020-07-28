---
title: PhpStorm 使用经验
permalink: phpstorm-using-experience
date: 2018-05-05 14:00:00
updated: 2020-07-28 11:27:50
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

![180416-use-php-cs-fixer-in-phpstorm-001](https://user-images.githubusercontent.com/9289792/88664953-715fb100-d110-11ea-970e-9dcb72945ebb.png)

- Program: `/usr/local/bin/php-cs-fixer`
- Arguments: `--verbose fix "$FileDir$/$FileName$" --dry-run --rules=@PSR1,@PSR2,@Symfony`（Note that previous verions of PHP-CS-Fixer used --levels instead of --rules. 未找到）
- Working directory: `$ProjectFileDir$`
- 我取消勾选了 `Open console for tool output`，可以不输出日志信息

为了方便使用，保存文件时就可以格式化，设置快捷键 `Preferences > Keymap > Macros`：

![180416-use-php-cs-fixer-in-phpstorm-002](https://user-images.githubusercontent.com/9289792/88665170-c996b300-d110-11ea-8acf-62dad3694f2d.png)

设置 php-cs-fix 单独的快捷键 `Preferences > Keymap > External Tools`：

![180416-use-php-cs-fixer-in-phpstorm-003](https://user-images.githubusercontent.com/9289792/80202900-e5de0c00-8658-11ea-826f-b4d058fa2209.png)

## 关闭不常用的插件

`Preferences > Plugins > Installed` 向下滚动，`Bundled` 中有不少预装但不常用的可以禁掉。

## References

- [打造漂亮的 PhpStorm 界面](https://laravel-china.org/articles/4172/create-beautiful-phpstorm-interface)
- [大牛们的 PHPstorm 使用技巧和建议](http://www.pilishen.com/posts/phpstorm-tips-and-tricks)
- [Use PHP-CS-Fixer in PHPStorm](https://gist.github.com/nienkedekker/3ddb9ece42233698c0e3f3e42cf1ff34)
