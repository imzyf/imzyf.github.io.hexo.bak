---
title: Linux | Mac 安装 Node.js 与常见问题
permalink: install-node-js-in-ubuntu-and-faq
date: 2017-07-06 17:00:00
updated: 2019-10-31 18:29:57
comments: true
toc: true
tags:
  - node-js
  - mac
categories:
description:
---

## Node.js 安装

推荐使用 nvm 安装管理 node.js

> the nvm method is definitely much more flexible.

[creationix/nvm: Node Version Manager - Simple bash script to manage multiple active node.js versions](https://github.com/creationix/nvm#installation)

To install or update nvm.

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
```

<!-- more -->

```bash
# Uses automatic LTS (long-term support) alias `lts/*`, if available.
nvm ls-remote --lts

# 安装最新 lts
nvm install --lts
# v10 lts
nvm install --lts=Dubnium

# 安装指定版本
nvm install v6.11.0

# Usually, nvm will switch to use the most recently installed version
nvm use v6.11.0

# You can see the version currently being used
node -v

# 其他命令可以查看帮助
nvm help
```

## nrm 源管理

nrm can help you easy and fast switch between different npm registries.

```bash
npm install -g nrm

nrm ls
nrm use taobao
```

## node-sass sh: node: command not found

> [config unsafe-perm | npmjs](https://docs.npmjs.com/misc/config#unsafe-perm)

解决办法：

```bash
npm install --unsafe-perm node-sass
```

`npm` 出于安全考虑不支持以 `root` 用户运行，即使你用 `root` 用户身份运行了，npm 会自动转成一个叫 `nobody` 的用户来运行，而这个用户几乎没有任何权限。这样的话如果你脚本里有一些需要权限的操作，比如写文件（尤其是写 /root/.node-gyp），就会报错了。

为了避免这种情况，要么按照 npm 的规矩来，专门建一个用于运行 npm 的高权限用户。要么加 `--unsafe-perm` 参数，这样就不会切换到 `nobody` 上，运行时是哪个用户就是哪个用户，即使是 `root`。

## version "N/A -> N/A" is not yet installed

出现了这个报错提示：

```bash
N/A: version "N/A -> N/A" is not yet installed.

You need to run "nvm install N/A" to install it before using it
```

List installed versions

```bash
$ nvm ls
->      v6.11.0
         v8.2.1
default -> 4 (-> N/A)
node -> stable (-> v8.2.1) (default)
stable -> 8.2 (-> v8.2.1) (default)
iojs -> N/A (default)
lts/* -> lts/boron (-> N/A)
lts/argon -> v4.8.4 (-> N/A)
lts/boron -> v6.11.1 (-> N/A)
```

Try nvm install in that directory to ensure it's installed.

```bash
nvm install --lts

nvm install iojs

nvm alias default v6.11.1
```

> References:
>
> - [How To Install Node.js on Ubuntu 16.04 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04)
> - [nvm node is recognised by npm install script. | GitHub](https://github.com/sass/node-sass/issues/2470)
> - [npm 的 --unsafe-perm 参数是有何作用呢？| segmentfault](https://segmentfault.com/q/1010000019365121)

-- EOF --
