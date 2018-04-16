---
title: 在 PHPStorm 中使用 PHP-CS-Fixer
permalink: use-php-cs-fixer-in-phpstorm
date: 2018-04-16 9:00:00
updated: 2018-04-16 9:00:00
comments: true
toc: true
tags:
   - php
   - phpstorm
categories:
description:
---

> [The PHP Coding Standards Fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer) (PHP CS Fixer) tool fixes your code to follow standards.

工作环境：MacBook。

打开 PHPStorm `Preferences > Tools > External Tools` 添加：

![Preferences > Tools > External Tools](https://cdn-qn.yifans.com/180416-use-php-cs-fixer-in-phpstorm-001.png)

<!-- more -->

- Program: `/usr/local/bin/php-cs-fixer`
- Parameters: `--rules=@Symfony --verbose fix "$FileDir$/$FileName$"`（Note that previous verions of PHP-CS-Fixer used --levels instead of --rules. 未找到）
- Working directory: `$ProjectFileDir$`
- 我取消勾选了 Open console，可以不输出日志信息

设置快捷键 `Preferences > Keymap`：

![Preferences > Keymap](https://cdn-qn.yifans.com/180416-use-php-cs-fixer-in-phpstorm-002.png)

> 相关阅读：
> - [Yifans_Z - Atom 插件 PHP-CS-Fixer 规范代码格式](/2017/06/13/atom-plugin-php-cs-fixer/)

---

> References:
> - [Use PHP-CS-Fixer in PHPStorm](https://gist.github.com/nienkedekker/3ddb9ece42233698c0e3f3e42cf1ff34)
