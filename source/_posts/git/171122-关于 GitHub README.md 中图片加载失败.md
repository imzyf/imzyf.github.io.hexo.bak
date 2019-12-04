---
title: 关于 GitHub README.md 中图片加载失败
permalink: github-readme-content-length-exceeded
date: 2017-11-22 16:00:00
updated:
tags:
  - git
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

## 遇到的问题

在编写 GitHub 的 README.md 后，其中引用的网络图片无法正常显示，点击 `alt` 的文字提示：`Content length exceeded`。

<!-- more -->

## 分析

根据 [About anonymized image URLs](https://help.github.com/articles/about-anonymized-image-urls/) 这篇文章：上传的图片 URL 将被修改，所以个人信息将不会被跟踪。GitHub 将使用 [开源项目 Camo](https://github.com/atmos/camo)。Camo 将为每一个图片生成一个以 `https://camo.githubusercontent.com/` 匿名代理 URL 同时隐藏来自其他用户的浏览器详细信息和相关信息。

我引用的 GIF 图片有 **7MB** 多，那么图片大小的限制是多少？

[camo - server.coffee#L18](https://github.com/atmos/camo/blob/master/server.coffee#L18)

```txt
content_length_limit = parseInt(process.env.CAMO_LENGTH_LIMIT || 5242880, 10)
```

换算后大小正好是 **5MB**。

> References:
>
> - [关于 GitHub 无法图片加载的问题](http://soyaine.cn/blog/2016/12/31/soyaine-daily-070)
