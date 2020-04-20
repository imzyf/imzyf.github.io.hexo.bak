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
cover_img: https://images.unsplash.com/photo-1517336714731-489689fd1ca8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=320&q=80
feature_img:
---

<img src="https://images.unsplash.com/photo-1517336714731-489689fd1ca8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=320&q=80" />

个人 MacBook 食用说明。推荐自动化环境配置脚本项目 [imzyf/dotfiles](https://github.com/imzyf/dotfiles)。

<!-- more -->

## 软件下载

> 设置安装源允许任何 `sudo spctl --master-disable`

使用 `brew cask` 安装软件，非常方便。

安装 [brew](https://brew.sh/)：

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# 查找软件
brew cask info iterm2

# 安装软件
brew cask install iterm2
```

## 软件清单

### 必备

- iTerm 2
- Alfred 3
- Google Chrome
- Visual Studio Code
- ImageOptim
- iHosts - 管理 Host - 
- The Unarchiver - 
- V2rayU
- 百度云 - BaiduNetdisk
- ~ShadowsocksX-NG~

```bash
brew cask install iterm2 alfred google-chrome visual-studio-code imageoptim v2rayu baidunetdisk
```

### Web 开发

- [Docker](https://www.docker.com/) - ✨✨✨
- Navicat for MySQL - ✨✨✨ - 💰
- Dash - ✨✨✨ - 💰
- [Sourcetree](https://www.sourcetreeapp.com/) - ✨✨✨
- Postman - API 管理 - ✨✨✨
- Firefox - ✨✨
- QQ 游览器 Lite -  - ✨
- [JetBrains Developer Tools](https://www.jetbrains.com/) 全家桶。
- ~~Sublime Text~~
- ~~Paw - API 管理~~

```bash
brew cask install docker dash sourcetree postman firefox
```

```bash
brew install php@7.2
```

### iOS 开发

- OpenSim - 快速打开模拟器应用文件夹 - ✨✨✨
- Reveal - UI 调试 - ✨✨✨ - 💰
- Charles - ✨✨✨ - 💰
- Flipper
- Realm Studio
- Wireshark

```bash
brew cask install opensim reveal charles
```

### 系统

- [Go2Shell](http://zipzapmac.com/go2shell) - 在当前 Finder 路径打开命令行 - ✨✨✨
- SecureCRT - SSH 管理 - ✨✨✨ - 💰
- ~~ShellCraft - SSH - 💰~~
- ~~[Transmit 5](https://panic.com/transmit/)~~
- [FileZilla](https://filezilla-project.org/) - FTP / SFTP
- ~~Shimo - 全局代理，命令行和开发软件内依然可以翻墙，支持 PPTP~~
- Itsycal - 日历扩展 - ✨✨✨
- Proxifier - 代理 - ✨✨✨ - 💰
- fliqlo - 时钟屏保 - 可以配合 `触发角` 使用 - ✨✨✨
- QuicklookStephen - QuickLook plugin - ✨✨✨
- PopClip - ✨
- typora - Markdown 编辑器 - 导出 PDF 的样式出色 - ✨✨✨
- Pap.er - 桌面壁纸
- Mounty
- Launchpad Manager Yosemite - 清理 Launchpad 图标
- CleanMyMac X
- [SlowQuitApps](https://github.com/dteoh/SlowQuitApps) - 延迟 `⌘ + q`
- Cyberduck - FTP

```bash
brew cask install go2shell itsycal fliqlo qlstephen PopClip typora paper
```

```bash
brew tap dteoh/sqa
brew cask install slowquitapps
```

### 效率

- [IINA](https://lhc70000.github.io/iina/) - The modern video player - ✨✨✨
- [LICEcap](https://www.cockos.com/licecap/) - GIF 录屏 - ✨✨✨
- ~~[RescueTime](https://www.rescuetime.com/) - 时间统计~~
- Evernote - 印象笔记
- 微信 - 
- QQ - 
- QQ 音乐 - 
- 网易有道词典 - 
- TeamViewer
- ~~Kindle - ~~
- MWeb
- Logitech Options
- 迅雷
- ~~[Scroll Reverser](http://pilotmoon.com/scrollreverser/) - 翻转设备滚动方向~~ 鼠标自然方向真香
- ~~网易云音乐~~ biss

```bash
brew cask install iina licecap
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
brew install autojump
```

## 快捷键

- [Mac 键盘快捷键](https://support.apple.com/zh-cn/HT201236)
- [Chrome 键盘快捷键](https://support.google.com/chrome/answer/157179?hl=zh-Hans)
- [iTerm2 快捷键](http://blog.csdn.net/qq_32457355/article/details/75043812)

### Mac

截屏：

- 全屏 `command + shift + 3`
- 指定区域 `command + shift + 4`
- 当前窗口 `command + shift+ 4 + 空格`

Finder：

- 前往文件夹 `command + shift + g`
- 显示简介 `command + i`
- 新建文件夹 `command + n`
- 搜索 `command + f`
- 删除 `command + delete`（在回收站中此方法为恢复文件，并不是从回收站删除）
- 清空回收站 `command + shift + delete`（全局可用）

切换：

- 所有应用之间切换 `command + tab`
- 部分应用内切换 tab `command + option + ←/→`（通常为浏览器）或者 `command + ←/→`
- 触摸板
  - 三指左右滑动，切换屏幕
  - 上滑，出现目前运行的窗口

前进/后退：

- 浏览器中 `command + ←` `command + ←`（这就解释了为什么浏览器不用这个切换 tab）
- 触摸板
  - 两指左滑
  - 两指右滑

浏览器:

- 放大缩小 `command + +` `command + -`
- 刷新 `command+r` 强制刷新：`command+shift+r`
- 进入开发者模式 `command+option+i`
- 打开上次关闭页面 `command+shift+t`

系统通用：

- 隐藏窗口 `command+h`
- 最小化窗口 `command+m`
- 新建窗口 `command+n`
- 新建 tab `command+t`
- 另存为 `command+shift+S`
- 关闭 tab `command+w`
- 退出窗口 `command + q`
- 复制粘贴 `command + c` `command + v`

其他：

- 单词跳跃 `option + ←` `option + →`
- 到开头 `command + ←` 到结尾 `command + →`，有的时候 `command` 不行换成 `fn`

## 手势

可以在 `系统偏好设置 -> 触控板` 中了解。

## 个性化设置

### 触发角

`系统偏好设置 -> 桌面与屏幕保护程序 -> 屏幕保护程序 -> 触发角`

### Night Shift

`系统偏好设置 -> 显示器 -> Night Shift`

-- EOF --
