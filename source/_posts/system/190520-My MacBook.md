---
title: My MacBook
permalink: my-macbook
date: 2019-05-20 17:14:59
updated: 2019-12-02 11:39:29
tags:
  - mac
categories:
description:
comments: true
toc: true
cover_img: https://cdn-qn.yifans.com/imzyf/robert-richarz-263241-unsplash.jpg
feature_img:
---

<img src="https://cdn-qn.yifans.com/imzyf/robert-richarz-263241-unsplash.jpg" alt="my-macbook" />

个人 MacBook 食用说明。推荐自动脚本项目 [imzyf/dotfiles](https://github.com/imzyf/dotfiles)。

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
- iHosts - 管理 Host - 
- The Unarchiver - 
- ~ShadowsocksX-NG~
- V2rayU
- 百度云 - BaiduNetdisk

```bash
$ brew cask install iterm2 alfred google-chrome visual-studio-code imageoptim v2rayu baidunetdisk
```

### Web 开发

- Docker - ✨✨✨
- Navicat for MySQL - ✨✨✨ - 💰
- Dash - ✨✨✨ - 💰
- SourceTree - ✨✨✨
- Postman - API 管理 - ✨✨✨
- Firefox - ✨✨
- QQ 游览器 Lite -  - ✨
- ~~Sublime Text~~
- ~~Paw - API 管理~~

```bash
$ brew cask install docker dash sourcetree postman firefox
```

```bash
$ brew install php@7.2
```

### iOS 开发

- OpenSim - 快速打开模拟器应用文件夹 - ✨✨✨
- Reveal - UI 调试 - ✨✨✨ - 💰
- Charles - ✨✨✨ - 💰
- Flipper
- Realm Studio
- Wireshark

```bash
$ brew cask install opensim reveal charles
```

### 系统

- go2shell - ✨✨✨
- SecureCRT - SSH 管理 - ✨✨✨ - 💰
- Itsycal - 日历扩展 - ✨✨✨
- Proxifier - 代理 - ✨✨✨ - 💰
- fliqlo - 时钟屏保 - 可以配合 `触发角` 使用 - ✨✨✨
- QuicklookStephen - QuickLook plugin - ✨✨✨
- PopClip - ✨✨
- typora - Markdown 编辑器 - ✨✨
- Pap.er - 桌面壁纸
- Mounty
- Launchpad Manager Yosemite - 清理 Launchpad 图标
- CleanMyMac X
- [SlowQuitApps](https://github.com/dteoh/SlowQuitApps) - 延迟 `⌘ + q`
- Cyberduck - FTP

```bash
$ brew cask install go2shell itsycal fliqlo qlstephen PopClip typora paper
```

```bash
$ brew tap dteoh/sqa
$ brew cask install slowquitapps
```

### 效率

- IINA - ✨✨✨
- LICEcap - GIF 录屏 - ✨✨✨
- RescueTime - 时间统计
- Evernote - 印象笔记
- 微信 - 
- QQ - 
- QQ 音乐 - 
- FileZilla
- 网易有道词典 - 
- TeamViewer
- Kindle - 
- MWeb
- Logitech Options
- 迅雷
- ~~网易云音乐~~

```bash
$ brew cask install iina licecap
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
- fish

```bash
$ brew install autojump
```
