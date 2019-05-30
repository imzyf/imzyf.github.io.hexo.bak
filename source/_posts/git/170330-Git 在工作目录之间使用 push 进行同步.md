---
title: Git 在工作目录之间使用 push 进行同步
permalink: git-synchronizing-between-working-directories-by-push
date: 2017-03-30 18:00:00
updated: 2018-01-18 19:00:00
comments: true
toc: true
tags:
   - git
description:
---

_Pushing to a non-bare repo is now possible (Git 2.3.0 February 2015)._

And it is possible when you are pushing the branch currently checked out at the remote repo!

现在已经是可以在俩个 non-bare 的仓库之间推送代码。

只需要再远程仓库配置：

```
git config receive.denyCurrentBranch updateInstead
```

就可以直接 `push` 分支到远程，并更新工作区。此方法可以用于项目部署。

<!--more -->

**receive-pack: add another option for `receive.denyCurrentBranch`**

When synchronizing between working directories, it can be handy to update the current branch via 'push' rather than 'pull', e.g. when pushing a fix from inside a VM, or when pushing a fix made on a user's machine (where the developer is not at liberty to install an ssh daemon let alone know the user's password).

The common workaround – pushing into a temporary branch and then merging on the other machine – is no longer necessary with this patch.

The new option is:

`updateInstead`: Update the working tree accordingly, but refuse to do so if there are any uncommitted changes.

in remote repo:

```
git config receive.denyCurrentBranch updateInstead
```

and then you can use `git push` to synchronize between working directories in local repo.

> Reference:
>
> - [cannot push into git repository - Stack Overflow](http://stackoverflow.com/questions/3221859/cannot-push-into-git-repository)
> - [receive-pack: add another option for receive.denyCurrentBranch](https://github.com/git/git/commit/1404bcbb6b3bdb248d32024430644e55faec91ce)
