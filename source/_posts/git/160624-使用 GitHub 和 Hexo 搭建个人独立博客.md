---
title: 使用 GitHub 和 Hexo 搭建个人独立博客
permalink: hexo-github-blog
date: 2016-06-24 18:30:00
updated: 2019-12-02 18:32:51
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

`Wordpress` 这类博客系统功能强大，可对与我只想划拉的写点东西的人，感觉大材小用了。而且 `Wordpress` 需要部署，网站的服务器也会带来问题，国内的服务器首先需要备案，费用不低，国外服务器访问速度受影响。

近来接触到一种新的博客系统 Hexo，它的不同地方就是将：**在上线编写博客和页面渲染的过程在线下完成**。

在本地编写博文的 Markdown 文件，使用 Hexo 将博客网站的所有前台 HTML 等全部生成，让后将生成的文件上传的服务器就行了。

那么原来 wp 中的评论等动态功能怎么办呢？放心第三方服务商早已为我们考虑了。例如：[disqus](https://disqus.com/)就是一家第三方社会化评论系统，主要为网站主提供评论托管服务。

本文的操作的系统环境是 Ubuntu 15，Windows 下的搭建可触类旁通。

## 了解 Hexo

> A fast, simple & powerful blog framework

[Hexo](https://hexo.io/) 是一个快速、简洁且高效的博客框架。Hexo 使用 Markdown（或其他渲染引擎）解析文章，在几秒内，即可利用靓丽的主题生成静态网页，[Hexo setup 官方文档](https://hexo.io/zh-cn/docs/setup.html)。

<!--more-->

## 安装 Git

> [Download for Linux and Unix | git-scm](https://git-scm.com/download/linux)

## 安装 Node.js

> [Linux | Mac 安装 Node.js 与常见问题 | zyf.im](/2017/07/06/install-node-js-in-ubuntu-and-faq/)

## 安装 Hexo

所有必备的应用程序安装完成后，即可使用 npm 安装 Hexo：

```bash
npm install -g hexo-cli
```

## 建站

安装 Hexo 完成后，请执行下列命令，Hexo 将会在指定文件夹中新建所需要的文件：

```bash
$ hexo init <folder>
$ cd <folder>
$ npm install
```

新建完成后，指定文件夹的目录如下：

```txt
├── _config.yml
├── package.json
├── scaffolds
├── source
| ├── _drafts
| └── _posts
└── themes
```

### 新建一篇文章

```bash
hexo new [layout] <title>
```

如果没有设置 layout 的话，默认使用 `_config.yml` 中的 default_layout 参数代替。如果标题包含空格的话，请使用引号括起来。

### 生成静态文件

```bash
hexo generate

# 可以简写为

hexo g
```

### 启动服务器

```bash
hexo server

# 可以简写为

hexo s
```

网站会在 [http://localhost:4000](http://localhost:4000) 下启动。在服务器启动期间，Hexo 会监视文件变动并自动更新，您无须重启服务器。

## 部署静态网页到 GitHub

### 注册设置 GitHub

1. 登录 GitHub，注册自定义用户名如：`imzyf`
2. 在主页右下角创建 New repository，name 必须和用户名一致如：`imzyf.github.io`
3. 等待 3 分钟左右，之后即可访问静态主页如：`https://imzyf.github.io`

### 同步内容至 GitHub

1. 在 Hexo 目录下 `git clone git@github.com:imzyf/imzyf.github.io.git`
2. 将 `public` 文件下的所有文件拷贝到 `imzyf.github.io` 下
3. `git add .` 增加当前子目录下所有更改过的文件至 index
4. `git commit -m 'xxx'` 提交到本地
5. `git push origin master` 将当前分支 push 到远程 master 分支
6. 最后访问主页`http://imzyf.github.io` 观察效果

## 绑定个人域名

在 GitHub 项目页面，Settings -> GitHub Pages，Source 选择 master branch，Custom domain 填写自己的域名，同时勾选 Enforce HTTPS 让你的网址支持 HTTPS。

在你的域名服务商那里，将填写的域名解析到：`<username>.github.io` 利于 `imzyf.github.io`。

## References

- [HellDog-使用 GitHub 和 Hexo 搭建免费静态 Blog](https://wsgzao.github.io/post/hexo-guide/)
