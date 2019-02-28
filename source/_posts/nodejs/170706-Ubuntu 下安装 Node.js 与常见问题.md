---
title: Ubuntu 下安装 Node.js 与常见问题
permalink: install-node-js-in-ubuntu-and-faq
date: 2017-07-06 17:00:00
comments: true
toc: true
tags:
   - node-js
   - ubuntu
description:
---

推荐使用 nvm 安装管理 node.js

> the nvm method is definitely much more flexible.

## Node.js Installation

[creationix/nvm: Node Version Manager - Simple bash script to manage multiple active node.js versions](https://github.com/creationix/nvm#installation)

To install or update nvm.

``` bash
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
```

<!-- more -->

The script clones the nvm repository to `~/.nvm` and adds the source line to your profile (`~/.bash_profile`, `~/.zshrc`, `~/.profile`, or `~/.bashrc`).

``` bash
export NVM_DIR="/home/moma/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
```

``` bash
# Uses automatic LTS (long-term support) alias `lts/*`, if available.
nvm ls-remote --lts
# 安装指定版本
nvm install v6.11.0
# 安装最新稳定版
nvm install stable

# Usually, nvm will switch to use the most recently installed version
nvm use v6.11.0

# You can see the version currently being used
node -v

# 其他命令可以查看帮助
nvm help
```

## cnpm Installation

npm client for China mirror of npm.

```
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

## version "N/A -> N/A" is not yet installed.

出现了这个报错提示：

``` bash
N/A: version "N/A -> N/A" is not yet installed.

You need to run "nvm install N/A" to install it before using it
```

List installed versions

``` bash
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

``` bash
nvm install --lts

nvm install iojs

nvm alias default v6.11.1
```

> Reference:
> - [How To Install Node.js on Ubuntu 16.04 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04)
