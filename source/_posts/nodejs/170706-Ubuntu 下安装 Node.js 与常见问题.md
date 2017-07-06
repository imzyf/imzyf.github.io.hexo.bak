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
``` bash
# To install or update nvm, you can use the install script using cURL
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh -o install_nvm.sh

# Run the script
sudo chmod 777 ./install_nvm.sh
./install_nvm.sh

# To find out the versions of Node.js that are available for installation
nvm ls-remote
nvm install v6.11.0

# Usually, nvm will switch to use the most recently installed version
nvm use v6.11.0

# You can see the version currently being used
node -v
```

## cnpm Installation
npm client for China mirror of npm.
```
npm install -g cnpm --registry=https://registry.npm.taobao.org
```

<!-- more -->

> Reference:
> - [How To Install Node.js on Ubuntu 16.04 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04)
