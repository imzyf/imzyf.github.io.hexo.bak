---
title: Git 提交 message 规范
permalink: git-commit-message-style-guide
date: 2019-06-04 14:07:46
updated: 2019-06-04 14:07:46
comments: true
toc: true
tags:
   - git
description:
---

commit message 应该清晰明了，说明本次提交的目的。基本公式：

```
<type>(<scope>): <subject>
```

<!-- more -->

完整公式：

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

## type

用于说明 commit 的类别，只允许使用下面 7 个标识。

- feat：新功能（feature）
- fix：修补 bug
- docs：文档（documentation）
- style：格式（不影响代码运行的变动）
- refactor：重构（即不是新增功能，也不是修改 bug 的代码变动）
- test：增加测试
- chore：构建过程或辅助工具的变动

## scope

用于说明 commit 影响的范围，比如数据层、控制层、视图层等等，视项目不同而不同。

## subject

是 commit 目的的简短描述，不超过 50 个字符。

1. 以动词开头，使用第一人称现在时，比如 change，而不是 changed 或 changes
2. 第一个字母小写
3. 结尾不加句号 `.`

## cli 工具

### commitizen cli

[commitizen/cz-cli](https://github.com/commitizen/cz-cli) 使用它提供的 `git cz` 命令替代我们的 `git commit` 命令，帮助我们生成符合规范的 commit message。

除此之外，我们还需要为 `commitizen` 指定一个 `Adapter` 比如：[commitizen/cz-conventional-changelog](https://github.com/commitizen/cz-conventional-changelog)（一个符合 Angular 团队规范的 preset）使得 `commitizen` 按照我们指定的规范帮助我们生成 commit message。

全局安装（首选）：

```
$ npm install -g commitizen cz-conventional-changelog
$ echo '{ "path": "cz-conventional-changelog" }' > ~/.czrc
```

项目级安装（首选）：

```
npm install -D commitizen cz-conventional-changelog
```

`package.json` 中配置：

```
"script": {
   ...,
   "commit": "git-cz",
},
"config": {
   "commitizen": {
      "path": "node_modules/cz-conventional-changelog"
   }
}
```

如果全局安装过 `commitizen`，那么在对应的项目中执行 `git cz` or `npm run commit` 都可以。

### 自定义规范

也许 Angular 的那套规范我们不习惯，那么可以通过指定 Adapter [leonardoanalista/cz-customizable](https://github.com/leonardoanalista/cz-customizable) 指定一套符合自己团队的规范。

### 校验 message

可以通过 [conventional-changelog/commitlint](https://github.com/conventional-changelog/commitlint) 校验 commit message。同时可以配合使用 [typicode/husky](https://github.com/typicode/husky) 🐶 Git hooks made easy。

### 生成 CHANGELOG

[conventional-changelog/standard-version](https://github.com/conventional-changelog/standard-version) 🏆 自动化版本和更新日志生成。

还看到一个有意思的库 [📦🚀 semantic-release](https://github.com/semantic-release/semantic-release) 待研究。

> References:
>
> - [你可能会忽略的 Git 提交规范 - juejin](https://juejin.im/entry/5b429be75188251ac85830ff)
> - [优雅的提交你的 Git Commit Message - juejin](https://juejin.im/post/5afc5242f265da0b7f44bee4)
> - [Commit message 和 Change log 编写指南 - ruanyifeng](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)
> - [AngularJS Git Commit Message Conventions - google docs](https://docs.google.com/document/d/1QrDFcIiPjSLDn3EL15IJygNPiHORgU1_OOAqWjiDU5Y/edit#)
