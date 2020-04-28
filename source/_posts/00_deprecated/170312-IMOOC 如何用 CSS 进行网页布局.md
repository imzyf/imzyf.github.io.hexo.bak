---
title: IMOOC 如何用 CSS 进行网页布局
permalink: imooc-how-to-use-css-for-web-layout
date: 2017-03-12 12:00:00
updated: 2019-04-10 19:05:00
tags:
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

**2019-05-25 更新：** 文章内容已经过时。页面布局现在使用：`栅栏` `flex`。

<!-- more -->

---

慕课网上【如何用 CSS 进行网页布局】学习笔记。一列布局、两列布局、三列布局、混合布局。

## 一列布局

```html
<style type="text/css">
  body {
    marin: 0;
    padding: 0;
  }
  .main {
    width: 800px;
    height: 300px;
    background: #ccc;
    margin: 0 auto;
  }
  .top {
    height: 100px;
    background: blue;
  }
  .foot {
    width: 800px;
    height: 300px;
    backround: red;
    maigin: 0 auto;
  }
</style>
<div class="top"></div>
<div class="main"></div>
<div class="foot"></div>
```

## 两列布局

```html
<style type="text/css">
  .main {
    width: 800px;
    margin: 0 auto;
  }
  body {
    margin: 0;
    padding: 0;
    font-size: 30px;
  }
  .left {
    width: 20%;
    height: 500px;
    float: left;
    background: #ccc;
  }
  .right {
    width: 80%;
    height: 500px;
    float: right;
    background: #ddd;
  }
</style>
<body>
  <div class="main">
    <div class="left"></div>
    <div class="right"></div>
  </div>
</body>
```

## 三列布局

中间自适应；注意 `position:absolute` 使用

```html
<style type="text/css">
  .left {
    height: 600px;
    width: 200px;
    background: #ccc;
    position: absolute;
    left: 0;
    top: 0;
  }
  .main {
    height: 600px;
    margin: 0 310px 0 210px;
    background: #9cf;
  }
  .right {
    height: 600px;
    width: 300px;
    position: absolute;
    right: 0;
    top: 0;
    background: #fcc;
  }
</style>

<div class="left">left</div>
<div class="main">设计首页的第一步是设计版面布局。</div>
<div class="right">right</div>
```

## 混合布局

```html
<style>
  body {
    margin: 0;
    padding: 0;
    font-size: 30px;
    font-weight: bold;
  }
  div {
    text-align: center;
    line-height: 50px;
  }
  .top {
    height: 100px;
    background: #9cf;
  }
  .head,
  .main {
    width: 960px;
    margin: 0 auto;
  }
  .head {
    height: 100px;
    background: #f90;
  }
  .left {
    width: 220px;
    height: 600px;
    background: #ccc;
    float: left;
  }
  .right {
    width: 740px;
    height: 600px;
    background: #fcc;
    float: right;
  }
  .r_sub_left {
    width: 540px;
    height: 600px;
    background: #9c3;
    float: left;
  }
  .r_sub_right {
    width: 200px;
    height: 600px;
    background: #9fc;
    float: right;
  }
  .footer {
    height: 50px;
    background: #9f9;
    clear: both;
  }
</style>

<div class="top">
  <div class="head">head</div>
</div>
<div class="main">
  <div class="left">left</div>
  <div class="right">
    <div class="r_sub_left">sub_left</div>
    <div class=" r_sub_right">sub_right</div>
  </div>
</div>
<div class="footer">footer</div>
```

![混合布局](https://img.mukewang.com/58525eb80001417a12800720.jpg)
