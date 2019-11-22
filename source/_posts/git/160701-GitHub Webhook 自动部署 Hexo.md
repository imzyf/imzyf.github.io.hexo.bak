---
title: GitHub Webhook 自动部署 Hexo
permalink: github-webhook-example
date: 2016-07-01 20:00:00
updated:
tags:
  - github
  - hexo
  - git
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

在 [GitHub Pages 不被百度收录解决方案](/2016/06/30/github-pages-forbidden-baiduspide-solution/) 中，思路二是通过 Dnspod 的智能 DNS 服务。简而言之就是搭建一个 Server，做一个 Blog 的镜像站，专为百度收录使用。

但是每次将新建的博客文章 `PUSH` 到 GitHub 后，还要再登陆 Server `PULL` 一下，简直是太蠢了。那有什么解决办法吗？答：GitHub Webhook。

<!-- more -->

## Webhook

Webhook，也就是人们常说的钩子，是一个很有用的工具。你可以通过定制 Webhook 来监测你在 Github.com 上的各种事件，最常见的莫过于 push 事件。

如果你设置了一个监测 push 事件的 Webhook，那么每当你的这个项目有了任何提交，这个 Webhook 都会被触发，这时 Github 就会发送一个 HTTP POST 请求到你配置好的地址。

如此一来，你就可以通过这种方式去自动完成一些重复性工作；比如，你可以用 Webhook 来自动触发一些持续集成（CI）工具的运作，比如 Travis CI；又或者是通过 Webhook 去部署你的线上服务器。

Github 开发者平台的文档中对 Webhook 的所能做的事是这样描述的：

> You’re only limited by your imagination.

## 响应 Webhook

在参考文章里博主是使用 Node.js 编写的服务端响应代码，但考虑到自己对 Node.js 不熟悉，还要部署环境，所以改用 Python 语言编写响应代码。

自己在 GitHub 搜索下 `github webhook`，`language` 选择 `Python` 便找到了 Python 编写的：[razius/github-webhook-handler](https://github.com/razius/github-webhook-handler)

自己的 VPS 是在 [Bandwagon Host](https://bandwagonhost.com/aff.php?aff=5403) 上购买的，最合适的配置：

- Self-managed service
- SSD: 10 GB
- RAM: 512 MB
- CPU: 1x Intel Xeon
- BW: 1000 GB/mo
- Link speed: 1 Gigabit
- VPS technology: OpenVZ/KiwiVM
- Linux OS: 32-bit and 64-bit Centos, Debian, Ubuntu, Fedora

费用：

- \$2.99 USD Monthly
- \$7.99 USD Quarterly
- \$12.99 USD Semi-Annually
- \$19.99 USD Annually

Bandwagon Host 支持支付宝付款很是方便，优惠码：`IAMSMART52J3NC` 再打个 9.5 折左右。这配置有时会 `(out of stock)` 等等随缘会有的。

### 安装 Git

```
apt-get update
apt-get install git
```

### clone [razius/github-webhook-handler](https://github.com/razius/github-webhook-handler)

```bash
git clone https://github.com/razius/github-webhook-handler.git
```

根据 github-webhook-handler Gettings started:

#### Installation Requirements

Install dependencies found in requirements.txt

```bash
pip install -r requirements.txt
```

#### Repository Configuration

Edit repos.json to configure repositories, each repository must be registered under the form `GITHUB_USER/REPOSITORY_NAME`.

```
{
    "razius/puppet": {
        "path": "/home/puppet",
        "key": "MyVerySecretKey",
        "action": [["git", "pull", "origin", "master"]]
    },
    "d3non/somerandomexample/branch:live": {
        "path": "/home/exampleapp",
        "key": "MyVerySecretKey",
        "action": [["git", "pull", "origin", "live"],
            ["echo", "execute", "some", "commands", "..."]]
    }
}
```

过程如果出现：`pip: command not found` 可以执行：

```
sudo apt-get install python-pip
```

#### Set environment variable for the repos.json config.

```
export REPOS_JSON_PATH=/path/to/repos.json
```

#### Start the server.

```
python index.py 80
```

#### clone and pull your Blog

```
git clone git@github.com:imzyf/imzyf.github.io.git
git pull origin master
```

过程如果出现：`Permission denied (publickey).` 可以参考：

- [Stack Overflow-Git - Permission denied (publickey)](http://stackoverflow.com/questions/2643502/git-permission-denied-publickey)

```
cd ~/.ssh && ssh-keygen
cat id_rsa.pub | xclip
```

然后添加到你的 GitHub 账户：Settings -> SSH keys 中。

### config imzyf.github.io Webhooks

首先进入你的 repo 主页，通过点击页面上的按钮 [settings] -> [Webhooks & service] 进入 Webhooks 配置主页面。也可以通过下面这个链接直接进入配置页面：

```
https://github.com/[ 用户名 ]/[ 仓库名称 ]/settings/hooks
```

此处只需要配置 Webhook 所发出的 POST 请求发往何处即可，于是我们就配置我们所需要的路径：
[http://104.236.xxx.xxx:9988/deploy/]()。这个地址指向的就是那个能够响应 Webhook 所发出请求的服务器。

配置好 Webhook 后，Github 会发送一个 ping 来测试这个地址。如果成功了，那么这个 Webhook 前就会加上一个绿色的勾；如果你得到的是一个红色的叉，那就好好检查一下哪儿出问题了吧！

### config Nginx server

## 最后想说的

为了一个百度收录大可不必这么麻烦，刚刚查到这些解决方案时心里也是烦的、虚的，但还是硬的头皮搞了。

过程中已经不单单是为了百度收录自己的博客，而是变成学习了东西、思考问题。这些解决方案网上都有，也不是自己创造的，但是别人的东西自己不尝试，就还是别人的。

现在百度已经收录我的博客了，imzyf.github.io 到 Server 也是自动部署的。解决问题后的快乐和信心，才是我这次最大的收获。

> Reference
>
> - [jerryzou-Webhook 实践 —— 自动部署](http://jerryzou.com/posts/webhook-practice/)
