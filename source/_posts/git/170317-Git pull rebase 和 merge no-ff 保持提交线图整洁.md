---
title: Git pull rebase 和 merge no-ff 保持提交线图整洁
permalink: git-pull-rebase-and-merge-no-ff-to-keep-clear-commit-graph
date: 2017-03-17 16:00:00
updated:
tags:
  - git
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

git log 中的一个清晰的提交线图是很方便进行 code review 和代码回退
`git pull --rebase` 主要是为是将提交约线图平坦化，而 `git merge --no-ff` 则是刻意制造分叉

## pull rebase

> perform a rebase after fetching

### 状况

Git 作为分布式版本控制系统，所有修改操作都是基于本地的，在团队协作过程中，假设你和你的同伴在本地中分别有各自的新提交，而你的同伴先于你 push 了代码到远程分支上，所以你必须先执行 `git pull` 来获取同伴的提交，然后才能 push 自己的提交到远程分支。

![170317-git-pull-rebase-and-merge-no-ff-to-keep-clear-commit-graph-01](https://user-images.githubusercontent.com/9289792/80202129-c1cdfb00-8657-11ea-814e-49f8618f301c.jpg)

按照 Git 的默认策略，如果远程分支和本地分支之间的提交线图有分叉的话（即不是 fast-forwarded），Git 会执行一次 merge 操作，因此产生**一次没意义的提交记录**，从而造成了像上图那样的混乱。

### 解决

其实在 pull 操作的时候，使用 `git pull --rebase` 选项即可很好地解决上述问题。 加上 `--rebase` 参数的作用是，提交线图有分叉的话，Git 会 `rebase` 策略来代替默认的 `merge` 策略。
假设提交线图在执行 pull 前是这样的：

```bash
                 A---B---C  remotes/origin/master
                /
           D---E---F---G  master
```

如果是执行 `git pull` 后，结果多出了 H 这个没必要的提交记录。提交线图会变成这样：

```bash
                 A---B---C remotes/origin/master
                /         \
           D---E---F---G---H master
```

如果是执行 `git pull --rebase` 的话，提交线图就会变成这样：

```bash
                       remotes/origin/master
                           |
           D---E---A---B---C---F'---G'  master
```

F G 两个提交通过 `rebase` 方式重新拼接在 C 之后，多余的分叉去掉了，目的达到。

### 注意

使用 `git log --graph` 可查看提交线图
使用 `git pull --rebase` 是为了使提交线图更好看，从而方便 code review 和代码回退
使用 `git pull --rebase` 比直接 pull 容易导致冲突的产生，如果预期冲突比较多的话，建议还是直接 pull

<!--more -->

## merge no-ff

> generate a merge commit even if the merge resolve

### 例子 1

`git pull --rebase` 策略目的是修整提交线图，使其形成一条直线，而即将要用到的 `git merge --no-ff <branch-name>` 策略偏偏是反行其道，刻意地弄出提交线图分叉出来。

假设你在本地准备合并两个分支，而刚好这两个分支是 fast-forwarded 的，那么直接合并后你得到一个直线的提交线图，当然这样没什么坏处，但如果你想更清晰地告诉你同伴：这一系列的提交都是为了实现同一个目的，那么你可以刻意地将这次提交内容弄成一次提交线图分叉。

执行 `git merge --no-ff <branch-name>` 的结果大概会是这样的：

![170317-git-pull-rebase-and-merge-no-ff-to-keep-clear-commit-graph-02](https://user-images.githubusercontent.com/9289792/80202132-c397be80-8657-11ea-8135-781a36fc64e5.jpg)

中间的分叉线路图很清晰的显示这些提交都是为了实现：**complete adjusting user domains and tags**

### 例子 2

往往在合并分支之前（假设要在本地将 feature 分支合并到 dev 分支），会先检查 feature 分支是否部分落后于远程 dev 分支：

```bash
git checkout dev
git pull # 更新 dev 分支
git log feature..dev # 对比
```

如果没有输出任何提交信息的话，即表示 feature 对于 dev 分支是 up-to-date 的。如果有输出的话而马上执行了 `git merge --no-ff` 的话，提交线图会变成这样：

![170317-git-pull-rebase-and-merge-no-ff-to-keep-clear-commit-graph-03](https://user-images.githubusercontent.com/9289792/80202134-c4305500-8657-11ea-8c4b-52f858f669ec.jpg)

所以这时在合并前，通常先执行：

```bash
git checkout feature
git rebase dev
```

这样就可以将 feature 重新拼接到更新了的 dev 之后，然后就可以合并了。这时分叉点将上移，最终得到一个干净舒服的提交线图

## 总结

- 使用 `git pull --rebase` 和 `git merge --no-ff` 其实和直接使用 `git pull` `git merge` 得到的代码应该是一样。
- 使用 `git pull --rebase` 主要是为是将提交约线图平坦化，而 `git merge --no-ff` 则是刻意制造分叉。

## References

- [洁癖者用 Git：pull --rebase 和 merge --no-ff](http://hungyuhei.github.io/2012/08/07/better-git-commit-graph-using-pull---rebase-and-merge---no-ff.html)

-- EOF --
