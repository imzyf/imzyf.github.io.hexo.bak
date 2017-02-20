---
title: Sublime Text killer — Atom 的使用技巧和快捷键
permalink: sublime-text-killer-atom-tips-and-shortcuts
date: 2016-12-08 19:00:00
updatetime: 2016-12-22 19:00:00
comments: true
toc: true
tags: 
   - atom
description: 
---

&emsp;&emsp;Atom 是由 GitHub 团队发布和维护的代码编辑器。发布于2014年，“Sublime Text killer” 拥有每月超过110万的用户，这并不奇怪：Atom 易于扩展，可定制和 hackable，Atom 已成为许多开发人员的最爱。
&emsp;&emsp;文章最后更新于：2016年12月22日
<!-- more -->

&emsp;&emsp;尽管它的广泛使用，我经常看到有能力的开发者采用绕远的方式做事，却不知道它的真正潜力。这篇文章探讨了一些改进你的 Atom 工作流的技巧。我希望当你阅读完时，你会学到至少一个你原来没有使用的新技巧。

&emsp;&emsp;注：虽然这篇文章是为 Atom 用户，但很多技巧和快捷方式也可以用在 Sublime Text 中。

### Tips 技巧
&emsp;&emsp;首先的一个 Atom 技巧是：你可以启用 IDE 中的那些你不了解的选项设置、功能。查看一遍所有的菜单设置是十分有价值的，你可能会发现到你原来不知道的事情。

#### Multiple Cursors 多行光标
&emsp;&emsp;多行光标将可以一次性的编辑文本中任何地方的多行内容。按住 **cmd** (Mac) 或 **ctrl** (Windows/Linux) 然后鼠标点击你想输入的地方。
![Multiple Cursors](https://dab1nmslvvntp.cloudfront.net/wp-content/uploads/2016/05/1464357838multcursor.gif)

#### Auto Indent 自动缩进
&emsp;&emsp;选中代码然后选择 Edit > Lines > Auto Indent 
![Auto Indent](https://dab1nmslvvntp.cloudfront.net/wp-content/uploads/2016/05/1464357903autoindent.gif)

&emsp;&emsp;为了提高效率可以将此设置快捷键，Edit > Keymap，`ctrl-}` 可以设置为任何你想的快捷键
```
'atom-text-editor':
    'ctrl-}': 'editor:auto-indent'
```

#### Show invisibles 显示不可见
&emsp;&emsp;为了确保文档和所有的行使用的正确的缩进，应该在编辑器中开启显示不可见。它将使用 `.` 表示空格缩进，`»` 表示 tab，`¬` 表示换行。这有助于你准确的查看出你哪里混合 tabs 或 无用的空格。
&emsp;&emsp;虽然在开始时这会让你的屏幕有些“乱”，但是你会很快的适应，而且将发现它很有价值
&emsp;&emsp;Atom (Mac) or Edit (Windows/Linux) > Preferences > (Scroll Down) Show Invisibles.

#### Soft wrap 软换行
&emsp;&emsp;左右拖动屏幕非常不方便，Soft wrap 可以使没有文字在屏幕的边缘。如果一行文字需要换行，它将缩进到与上一行相同的级别，并用一个 `·` 将替换行号。
&emsp;&emsp;Atom (Mac) or Edit (Windows/Linux) > Preferences > (Scroll Down) Soft Wrap.

#### Character case convert 大小写转换
&emsp;&emsp;Edit > Text 菜单中有很多实用的文本操纵工具

### Packages 插件

Packages are a compelling reason for choosing Atom. The ability to install and change anything and everything is what makes this code editor so great. I’m not about to reel off the best plugins that you must have installed — there are plenty of posts that do that already.

Instead, I’m going to tell you to install every one that you come across, then uninstall the ones you don’t like (or add too many precious seconds to your start-up time). If you go to Settings > Packages and click on an installed extension, it tells you how many milliseconds it adds to boot-up time.

These are a few packages that I rely on daily and that I haven’t seen listed in many other blog posts:

Project Manager
Git Plus
Minimap
Pigments.
atom-beautify（格式化代码）
file-icons（文件图标）



### Keyboard Shortcuts 快捷键

#### Duplicate line 重复行
```
Cmd + Shift + D (Mac)
Ctrl + Shift + D (Windows/Linux)
```
&emsp;&emsp;它允许您将光标放在行上的任何位置并复制它。
&emsp;&emsp;它非常有助于复制 CSS 选择器，渐变或表格单元格。当然，您也可以通过突出显示它们或使用多个游标同时复制多行：

#### Move the current line Up or Down 向上或向下移动当前行
```
Cmd + Up (or Down) Arrow (Mac)
Ctrl + Up (or Down) Arrow (Windows/Linux)
```
&emsp;&emsp;无论你的光标在哪里，此快捷方式都会将当前行移动到其周围的行上方或下方。
&emsp;&emsp;如果选择了多行，它将移动整个块（和自动缩进）

#### Select the next matching characters 选中下一匹配的字符
```
Cmd + D (Mac)
Ctrl + D (Windows/Linux)
```
&emsp;&emsp;此命令可以允许你选中下一匹配的字符，并以高亮显示。然后你可以（使用自动生成的多个光标）删除、编辑或更新这些值字符。

![Select the next matching characters](https://dab1nmslvvntp.cloudfront.net/wp-content/uploads/2016/05/1464358146matching.gif)

&emsp;&emsp;如果你只想更新几个值或属性，而不使用 find 和 replace，这是特别有用的。

#### Unselect the next matching characters 取消选中下一匹配的字符
```
Cmd + U (Mac)
Ctrl + U (Windows/Linux)
```
&emsp;&emsp;如果你选择下一个匹配的字符，有时跨度将很大。此快捷方式将以相反的顺序取消选择最近选择的字符。

#### Select all matching characters 选择所有匹配的字符
```
Cmd + Ctrl + G (Mac)
Alt + F3 (Windows/Linux)
```
&emsp;&emsp;有时你想批量编辑文档中的所有匹配字符，而不是每次按 Cmd / Ctrl + D。 此快捷方式选择与您选择的内容相匹配的所有内容。（警告：大量的选择将严重减慢Atom！）

#### Toggle comments (on and off) 切换注释（开启和关闭）
```
Cmd + / (Mac)
Ctrl + / (Windows/Linux)
```
&emsp;&emsp;有些情况下，你想要注释掉一行或多行。 此快捷方式使用正确的注释语法为当前行（或行的选择）适当地注释。你不再需要再次记住 `<!----> ` 或 `/**/`。

#### 函数括号前后之间的切换
```
ctrl + m
```

#### Markdown 预览
```
ctrl + shift + m
```

####  查看当前可以使用的代码块
```
alt + shift + s
```

#### 放大和缩小代码
```
ctrl + 鼠标滚动
```

#### 进入变量、函数跳转面板
```
ctrl + r
```

#### 行号跳转
```
ctrl + g
```

> reference:
> - [12 Favorite Atom Tips and Shortcuts to Improve Your Workflow](https://www.sitepoint.com/12-favorite-atom-tips-and-shortcuts-to-improve-your-workflow/)
> - [Atom技巧总结 · Issue #30 · Wscats/Good-text-Share](https://github.com/Wscats/Good-text-Share/issues/30)
