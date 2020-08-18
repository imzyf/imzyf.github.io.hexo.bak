---
title: Composer vendor 提交至 Git
permalink: commit-composer-vendor-to-git
date: 2020-08-10 14:24:47
updated:
tags:
  - php
  - composer
  - git
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1519682337058-a94d519337bc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=640&q=80
feature_img:
---

## 应该将 vendor 提交到 Git 吗

一般建议是 **不**。`vendor` 目录应添加到 `.gitignore`。

最佳实践是让所有开发人员使用 Composer 来安装依赖项。类似地，构建服务器、CI、部署工具等都应该作为项目启动的一部分来运行 Composer。

虽然在某些环境下这样做很诱人，但也会导致一些问题：

- 大型 VCS 存储库的大小和更新代码时的差异。
- 在你自己的 VCS 复制你所有依赖的历史。
- 将通过 git 安装的依赖项添加到 git repo 中将显示为 `submodules`。这是有问题的，因为它们不是真正的 `submodules`，您将会遇到问题。

如果你真的觉得你必须这样做，你有几个选择：

- 限制自己安装带标记的版本（没有 dev 版本），这样就只能安装压缩版，并避免与 git `submodules` 有关的问题。
- Use `--prefer-dist` or set `preferred-install` to `dist` in your config.
- Remove the `.git` directory of every dependency after the installation, then you can add them to your git repo. You can do that with `rm -rf vendor/\*\*/.git` in ZSH or `find vendor/ -type d -name ".git" -exec rm -rf {} \;` in Bash. 但这意味着您必须在运行 composer 更新之前从磁盘中删除这些依赖项。
- Add a `.gitignore` rule `/vendor/**/.git` to ignore all the vendor `.git` folders. 这种方法不需要在运行编写器更新之前从磁盘删除依赖项。

## 我的做法

> 问题解决了，但是不确信做法是否正确。

因为网络环境与部署的原因，在生产环境下是将 `vendor` 目录提交到 `git` 中的。使用过程中确实出现了，部分类库成为了 `submodules`，无法把真实的代码提交进 git。

可尝试执行：

```bash
git rm rf --cache vendor
git add .
git commit -m "add vendor"
```

## References

- [Should I commit the dependencies in my vendor directory? | getcomposer](https://getcomposer.org/doc/faqs/should-i-commit-the-dependencies-in-my-vendor-directory.md)

-- EOF --
