---
title: 解决 Too many symbol files
permalink: correct-too-many-symbol-files-issues
date: 2018-10-30 14:00:00
updated: 2018-10-30 14:00:00
comments: true
toc: true
tags:
   - ios
categories:
description:
---

在上传 App 到 App Store 后收到邮件，有 issues **Too many symbol files**。在之前看到 *Your delivery was successful*，此 issues 不影响发布，所以一直搁置了。

今天决定彻底处理下。

<!-- more -->

## 背景

先说 `*.symbols` 这文件是干嘛的，我现在（2018-10）对此的理解：

- symbols 为符号表文件
- 符号表是内存地址与函数名、文件名、行号的映射表 `<起始地址> <结束地址> <函数> [<文件名:行号>]`

为什么要配置符号表？

为了能快速并准确地定位用户 App 发生 **Crash 的代码位置**，使用符号表对 App 发生 Crash 的程序 *堆栈* 进行 *解析* 和 *还原*。

![为什么要配置符号表](https://ws3.sinaimg.cn/large/006tNbRwly1fwq98vcjeoj30i00383yh.jpg)

## 项目情况

再说下项目情况，因为数字都是用了的是 Int，为防止 32 位设备发生越界情况（理由好像有点扯），所以项目端设置了设备限制 `arm64`，也就是 5s 之前的设备不可以安装。

因为使用了三方库，但是三方库是支持 32 位设备的，所以生成了冗余的 symbols 文件。

查询 symbols 文件的生成情况：Xcode Window -> Organizer 选择有问题的 archive，右击选择 Show in finder，命令行进入 \*.app 中的 dSYMs 文件夹，执行 `dwarfdump --uuid *` 可以查询到是否生成了多余的文件。

## 解决

在 `Podfile` 中：

```
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['ARCHS'] = 'arm64'
    end
  end
end
```

## 检查

在 `info.plist` 中：

```
<key>UIRequiredDeviceCapabilities</key>
<array>
    <string>arm64</string>
</array>
```

在 build Settings 搜索 `valid architecture` 中，填写 `arm64`

> Reference:
> - [“Too many symbol files” after successfully submitting my apps](https://stackoverflow.com/questions/25755240/too-many-symbol-files-after-successfully-submitting-my-apps)
> - [“Too many symbol files” warnning when submitting app
](https://stackoverflow.com/questions/34313049/too-many-symbol-files-warnning-when-submitting-app)
> - [App提交iTunes Connect,"二进制无效"问题解决方案。](https://www.jianshu.com/p/3511ec38ca20)
> - [Bugly iOS 符号表配置](https://bugly.qq.com/docs/user-guide/symbol-configuration-ios/?v=20180709165613#_2)
