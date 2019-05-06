---
title: fastlane 入门使用
permalink: fastlane-getting-started
date: 2019-02-28 10:00:00
updated: 2019-02-28 10:00:00
comments: true
toc: true
tags:
   - ios
   - fastlane
categories:
description:
---

<img src="https://cdn-qn.yifans.com/imzyf/caleb-george-352-unsplash.jpg" alt="fastlane-getting-started" />

这次以 [fastlane](https://fastlane.tools/) 为例，尝试项目中有什么事情可以被自动完成。

fastlane 是 Ruby scripts 的集合，安装方法不多说了见 [官网文档](https://docs.fastlane.tools/)。

fastlane 中有但不限于以下工具集：

- [produce](https://docs.fastlane.tools/actions/produce/) 同时在 Apple Developer Portal 和 App Store Connect 中创建新的 iOS apps。
- [cert](https://docs.fastlane.tools/actions/cert/) 自动创建和维护 iOS 签名证书。
- [sigh](https://docs.fastlane.tools/actions/sigh/) 创建，更新，下载和修复配置文件。
- [snapshot](https://docs.fastlane.tools/actions/snapshot/) 自动在每台设备上获取 iOS 应用的本地化屏幕截图。
- [frameit](https://docs.fastlane.tools/actions/frameit/) 将您的屏幕截图放入正确的设备框架中。
- [gym](https://docs.fastlane.tools/actions/gym/) 构建和打包您的 iOS apps。
- [deliver](https://docs.fastlane.tools/actions/deliver/) 将截图，元数据和您的应用上传到 App Store。
- [pem](https://docs.fastlane.tools/actions/pem/) 自动生成并更新推送通知配置文件。
- [spaceship](https://github.com/fastlane/fastlane/tree/master/spaceship) 一个 Ruby 库能够访问苹果开发者中心和应用商店连接 api。
- [pilot](https://docs.fastlane.tools/actions/pilot/) 自动化 TestFlight 部署并管理测试用户。
- [boarding](https://github.com/fastlane/boarding) 邀请 beta 测试人员。
- [match](https://docs.fastlane.tools/actions/match/) 使用 Git 同步整个团队的证书和配置文件。
- [scan](https://docs.fastlane.tools/actions/scan/) 运行 app 测试。

<!-- more -->

> 实验环境：Xcode 10.1、Swift 4.2、fastlane 2.116.1、\$99 开发者账户

## 项目添加 fastlane

在项目根目录下：

```
fastlane init
```

在出现 `What would you like to use fastlane for?` 是选择 `4 Manual setup`，在根据提示回车确认。

之后项目文件中将新增：

- `Gemfile` 这个文件包含了 fastlane gem 的依赖
- `fastlane` 这个文件夹包含
  - `Appfile` 存储 app identifier，Apple ID 以及 fastlane 设置 app 所需的任何其他标识信息
  - `Fastfile` 管理 lanes 创建的可被调用的 actions

## 创建 App

打开 `Fastfile` 将里面所有内容替换为：

```
default_platform(:ios)

platform :ios do
# 1 lane 的描述
  desc "Create app on Apple Developer and App Store Connect sites"
# 2 create_app 是这个 lane 的名字
  lane :create_app do
# 3 使用 produce action 将 app 添加到 Developer Portal 和 App Store Connect
​    produce
  end
end
```

打开 `Appfile` 将 `apple_id` 前的 # 移除，将 `[[APPLE_ID]]` 替换为真实 Apple ID，这样 fastlane 将不会反复提示你输入。

如果 App Store Connect 和 Apple Developer Portal 可以将 `apple_id` 替换为：

```
apple_dev_portal_id("[[APPLE_DEVELOPER_ACCOUNT_USERNAME]]")
itunes_connect_id("[[APP_STORE_CONNECT_ACCOUNT_USERNAME]]")
```

打开命令行在项目目录输入：

```
fastlane create_app
```

根据提示输入密码，之后将提示你输入 bundle ID，以反 host 格式创建 ID，之后是 App name 最长 30 个字符。

完成后登陆 Apple Developer Center 和 App Store Connect，app 在二者已经都被创建了。

再次打开 Appfile 将 `app_identifier` 填写刚才创建的 bundle ID。

## 生成交付文件

```
bundle exec fastlane deliver
```

根据提醒暂不使用 Swift 代替 Ruby，因为 `fastlane.swift` 现在为 beta。

完成后 fastlane 文件夹中新增：

- `metadata` 这个文件夹存放了 app 大部分的 metadata 元数据
- `Deliverfile` 保存这剩余小部分的元数据
- `screenshots` 将保存 app 截图

<img src="https://ws2.sinaimg.cn/large/006tKfTcly1g0lz3u80l5j31eb0e6q8a.jpg" alt="fastlane-getting-started-metadata"/>

`metadata` 文件夹中文件内容就是提交给 App Store Connect，多语言 app 可以手动创建对应的语言文件夹。

更多 `deliver` 参数见 [这里](https://docs.fastlane.tools/actions/deliver/#more-options)

## 自动截图

多种设备和多语言 app 的截图是繁杂的。

```
fastlane snapshot init
```

fastlane 文件夹中新增：`Snapfile`，将里面的所有内容替换为一下：

```
# 1 - 想截图的设备列表

devices([
  "iPhone 8 Plus",
  "iPhone SE"
])

# 2 - 支持的语言列表

languages([
  'en-US',
  'fr-FR'
])

# 3 - 包含 UI Tests 的 scheme 名字

scheme("mZone Poker UITests")

# 4 - 截图存储位置

output_directory "./fastlane/screenshots"

# 5 - 是否清理之前的截图

clear_previous_screenshots(true)
```

保存关闭，然后命令中执行：

```
fastlane snapshot init
```

<img src="https://ws1.sinaimg.cn/large/006tKfTcly1g0m3olslyhj30vq0ft44l.jpg" alt="fastlane-getting-started-screenshots" style="width: 600px; display: block; margin: auto;" />

### 创建 Test Target

在 Xcode 选择 File -> New -> Target 选择 iOS UI Testing Bundle 点击 Next。

<img src="https://ws2.sinaimg.cn/large/006tKfTcly1g0m6hxg0dej30m80g0781.jpg" alt="fastlane-getting-started-screenshots" style="width: 600px; display: block; margin: auto;" />

Product Name 输入上面 `scheme` 填写的名字 MZone Poker UITests 点击 Finish。

之后将 fastlane 文件夹中的 SnapshotHelper.swift 拖到 mZone Poker UITests 中。

之后将 mZone_Poker_UITests.swift 中的 setUp() 和 tearDown() 移除，替换 testExample()：

```
// 1 设置截屏和启动 app
let app = XCUIApplication()
setupSnapshot(app)
app.launch()
// 2 点击 Chip Count 输入框（在 Storyboard 中的 accessibility identifier 设置 "chip count"）然后输入 10
let chipCountTextField = app.textFields["chip count"]
chipCountTextField.tap()
chipCountTextField.typeText("10")
// 3 点击 Big Blind 输入框 然后输入 100
let bigBlindTextField = app.textFields["big blind"]
bigBlindTextField.tap()
bigBlindTextField.typeText("100")
// 4 截图
snapshot("01UserEntries")
// 5 点击 what should i do 再进行截图
app.buttons["what should i do"].tap()
snapshot("02Suggestion")
```

之后创建 mZone Poker UITests scheme，点击 run stop 右边的按钮选择 `Manage Schemes...`

<img src="https://ws1.sinaimg.cn/large/006tKfTcly1g0m88o46ovj30m80ccdit.jpg" alt="fastlane-getting-started-create-test-target" style="width: 600px; display: block; margin: auto;" />

选择 `Edit Schemes...` 勾选 `Test` 和 `Run`

<img src="https://ws2.sinaimg.cn/large/006tKfTcly1g0m8eq3o8uj30m80c0di3.jpg" alt="fastlane-getting-started-create-test-target" style="width: 600px; display: block; margin: auto;" />

打开 Fastfile 添加：

```
desc "Take screenshots"
lane :screenshot do
  snapshot
end
```

命令行执行：

```
bundle exec fastlane screenshot
```

完成后将自动打开：

<img src="https://ws4.sinaimg.cn/large/006tKfTcly1g0m8gy5vl9j30df0dwgpb.jpg" alt="fastlane-getting-started-create-test-target" style="width: 600px; display: block; margin: auto;" />

## 创建 IPA 文件

首先要确保已经 `target` 设置 `bundle identifier` 和 `signing identity`。

命令行执行：

```
fastlane gym init
```

打开 `Gymfile` 替换为以下内容：

```
# 1 指定 scheme
scheme("mZone Poker")
# 2 指定存放 .ipa 文件夹
output_directory("./fastlane/builds")
# 3 从构建中排除 bitcode。Bitcode 允许 Apple 优化你的 app，但是现在排除它以提高构建速度。
include_bitcode(false)
# 4 从构建中排除符号。包含符号允许 Apple 访问应用程序的调试信息，但是现在排除它以提高构建速度。
include_symbols(false)
# 5 允许 Xcode 使用自动配置。
export_xcargs("-allowProvisioningUpdates")
```

打开 `Fastfile` 添加：

```
desc "Create ipa"
lane :build do
  # 1 允许 Xcode 自动配置
  enable_automatic_code_signing
  # 2 构建号自增（App Store Connect 要求构建号不能重复）
  increment_build_number
  # 3 创建签名的 .ipa 文件
  gym
end
```

保存后命令行执行：

```
bundle exec fastlane build
```

<img src="https://ws1.sinaimg.cn/large/006tKfTcly1g0m8ua4im3j30xy0ceaca.jpg" alt="fastlane-getting-started-create-test-target" style="width: 600px; display: block; margin: auto;" />

## 上传到 App Store Connect

使用 `deliver` 将截图、元数据、.ipa 文件上传到 App Store Connect。

替换 `Deliverfile` 内容：

```
# 1 价格为 0 则是免费应用
price_tier(0)
# 2 回答 Apple 在手动提交审核时会向您呈现的问题
submission_information({
    export_compliance_encryption_updated: false,
    export_compliance_uses_encryption: false,
    content_rights_contains_third_party_content: false,
    add_id_info_uses_idfa: false
})
# 3 提供应用评级配置位置
app_rating_config_path("./fastlane/metadata/app_store_rating_config.json")
# 4 提供.ipa文件位置
ipa("./fastlane/builds/mZone Poker.ipa”)
# 5 将s ubmit_for_review 设置为 true 以自动提交应用以供审核
submit_for_review(true)
# 6 必须在应用审核接受后手动发布应用
automatic_release(false)
```

在 `Fastfile` 中添加：

```
desc "Upload to App Store"
lane :upload do
  deliver
end
```

然后命令行执行：

```
bundle exec fastlane upload
```

完成后，登录 App Store Connect。屏幕截图，元数据和构建应该在那里，等待审查。

## 将命令放在一起

打开 `Fastfile` 添加：

```
desc "Create app, take screenshots, build and upload to App Store"
lane :do_everything do
  create_app
  screenshot
  build
  upload
end
```

在 `Deliverfile` 添加：

```
force(true)
```

执行：

```
bundle exec fastlane do_everything
```

> Reference:
>
> - [fastlane Tutorial: Getting Started](https://www.raywenderlich.com/233168-fastlane-tutorial-getting-started)

-- EOF --
