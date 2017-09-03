---
title: Git checkout --theirs 解决冲突文件
permalink: git-checkout-theirs-resolve-conflict
date: 2017-08-30 20:00:00
comments: true
toc: true
tags:
   - git
description:
---
在代码合并时遇到 `conflict` 是常有的事情，有些内容是自动生成的资源文件，手工处理起来很麻烦，某一文件如何全部以某一分支的内容为准？

使用 `checkout --theirs`。

<!-- more -->

## 实例情况
两个分支 `master` 和 `dev`，`dev` 是从 `master` 顶端 `checkout` 出来的。

在 `dev` 修改了 file.xml 文件后进行提交，到达 `b` 节点，在 `master` 修改了 file.xml 文件后进行提交，到达 `c` 节点。

这时在 `dev` 执行 rebase 命令，想让 `dev` 保存线性，`b` 节点应用在 `c` 节点之后：
```
$ git rebase master
```

因为 `master` 和 `dev` 修改了 file.xml 同一位置，产生冲突。

## 解决冲突
此时想完全以 `dev` 中的 file.xml 内容为准则可以使用：
```
$ git checkout --theirs file.xml
$ git add file.xml
...
```

如果想以 `master` 为准：
```
$ git checkout --ours file.xml
```

> Reference:
> - [化解冲突：git merge 与 git rebase 中的 ours 和 theirs](https://bitmingw.com/2017/02/16/git-merge-rebase-ours-and-theirs/)