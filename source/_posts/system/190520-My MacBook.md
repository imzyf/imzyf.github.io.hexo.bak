---
title: My MacBook
permalink: my-macbook
date: 2019-05-20 17:14:59
updated: 2019-06-17 14:15:22
comments: true
toc: true
tags:
   - mac
categories:
description:
---

<img src="https://cdn-qn.yifans.com/imzyf/robert-richarz-263241-unsplash.jpg" alt="my-macbook" />

个人 MacBook 食用说明。

<!-- more -->

## 软件下载

使用 `brew cask` 安装软件，非常方便。

安装 [brew](https://brew.sh/)：

```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# 查找软件
$ brew cask info iterm2

# 安装软件
$ brew cask install iterm2
```

## 软件清单

### 必备

- iTerm 2
- Alfred
- Google Chrome
- Visual Studio Code
- ImageOptim
- iHosts - 管理 Host
- The Unarchiver
- ShadowsocksX-NG
- 百度云 - BaiduNetdisk

```bash
$ brew cask install iterm2 alfred google-chrome visual-studio-code imageoptim shadowsocksx-ng baidunetdisk
```

### Web 开发

- Docker - 5 星
- Navicat for MySQL - 5 星 - 付费
- Dash - 5 星 - 付费
- SourceTree - 5 星
- Firefox - 4 星
- Sublime Text - 4 星
- Postman - API 管理 - 4 星
- QQ 游览器 Lite - 3 星
- ~~Paw - API 管理~~

```bash
$ brew cask install docker dash sourcetree firefox sublime-text postman
```

```bash
$ brew install php@7.2
```

### iOS 开发

- OpenSim - 快速打开模拟器应用文件夹 - 5 星
- Reveal - UI 调试 - 5 星 - 付费
- Charles - 5 星 - 付费
- Flipper
- Realm Studio
- Wireshark

```
$ brew cask install opensim reveal charles
```

### 系统

- go2shell - ✨✨✨
- SecureCRT - SSH 管理 - ✨✨✨ - 付费
- Itsycal - 日历扩展 - ✨✨✨
- Proxifier - 代理 - ✨✨✨ - 付费
- fliqlo - 时钟屏保 - 可以配合 `触发角` 使用 - ✨✨✨
- PopClip - ✨✨
- Pap.er - 桌面壁纸
- Mounty
- Launchpad Manager Yosemite - 清理 Launchpad 图标
- CleanMyMac X
- [SlowQuitApps](https://github.com/dteoh/SlowQuitApps) - 延迟 `⌘ + q`
- typora - Markdown 编辑器 - ✨✨

```bash
$ brew cask install go2shell itsycal popclip fliqlo typora
```

```bash
$ brew tap dteoh/sqa
$ brew cask install slowquitapps
```

### 效率

- IINA - 5 星
- LICEcap - GIF 录屏 - 5 星
- RescueTime - 时间统计
- Evernote - 印象笔记
- 微信
- QQ
- FileZilla
- 网易云音乐
- 网易有道词典
- TeamView
- Kindle
- MWeb
- Logitech Options
- 迅雷

```bash
$ brew cask install iina licecap rescuetime
```

### 产品

- Axure RP 8
- MindNode
- StarUML

### 设计

- Zeplin
- Sip - 拾色

## CLI

- dict
- zsh
- oh-my-zsh
- autojump

```bash
$ brew install autojump
```
