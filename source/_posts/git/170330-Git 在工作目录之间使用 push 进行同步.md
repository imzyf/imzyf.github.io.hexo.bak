---
title: Git 在工作目录之间使用 push 进行同步
permalink: git-synchronizing-between-working-directories-by-push
date: 2017-03-30 18:00:00
comments: true
toc: true
tags:
   - git
description:
---
*Pushing to a non-bare repo is now possible (Git 2.3.0 February 2015).*
And it is possible when you are pushing the branch currently checked out at the remote repo!
<!--more -->
**receive-pack: add another option for `receive.denyCurrentBranch`**
When synchronizing between working directories, it can be handy to update the current branch via 'push' rather than 'pull', e.g. when pushing a fix from inside a VM, or when pushing a fix made on a user's machine (where the developer is not at liberty to install an ssh daemon let alone know the user's password).

The common workaround – pushing into a temporary branch and then merging on the other machine – is no longer necessary with this patch.

The new option is:

'updateInstead':
&emsp;&emsp;Update the working tree accordingly, but refuse to do so if there are any uncommitted changes.

in remote repo:
```
git config receive.denyCurrentBranch updateInstead
```

and then you can use `git push` to synchronize between working directories in local repo.


> Reference:
> - [cannot push into git repository - Stack Overflow](http://stackoverflow.com/questions/3221859/cannot-push-into-git-repository)
> - [receive-pack: add another option for receive.denyCurrentBranch](https://github.com/git/git/commit/1404bcbb6b3bdb248d32024430644e55faec91ce)
