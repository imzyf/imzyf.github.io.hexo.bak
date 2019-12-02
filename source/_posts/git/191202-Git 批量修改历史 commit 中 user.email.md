---
title: Git 批量修改历史 commit 中 user.email
permalink: git-modify-history-commont-user-email
date: 2019-12-02 14:47:28
updated:
tags:
  - git
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1562240020-ce31ccb0fa7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=480&q=80
feature_img:
---

注意：**此操作会修改 Git 历史记录**，正式工作环境慎用。

<!-- more -->

- OLD_EMAIL 原来的邮箱
- CORRECT_NAME 更正的名字
- CORRECT_EMAIL 更正的邮箱

```bash
git filter-branch -f --env-filter '
OLD_EMAIL="old@qq.com"
CORRECT_NAME="MyNane"
CORRECT_EMAIL="new@qq.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
```

因为修改了 Git 历史所有要使用强制推送：

```bash
git push --f
```

GitLab 有 master 分支保护的策略：

```bash
remote: GitLab: You are not allowed to force push code to a protected branch on this project.
```

在 GitLab 中：Project(项目) -> Setting -> Repository 菜单下面的 Protected branches 把 master 的保护去掉就可以了。

> References:
>
> - [Git 批量修改历史 commit 中的 user.name 和 user.email | segmentfault](https://segmentfault.com/a/1190000008032330)
