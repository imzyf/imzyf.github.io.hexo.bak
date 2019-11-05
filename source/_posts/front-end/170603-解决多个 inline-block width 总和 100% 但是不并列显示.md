---
title: 解决多个 inline-block width 总和 100% 但是不并列显示
permalink: resolving-multiple-inline-block-not-in-a-single-row
date: 2017-06-03 09:00:00
comments: true
toc: true
tags:
   - css
categories:
description:
---

今天遇到一个问题：两个宽度和为 100% 的内联块，没有能在同一行并列显示，第二个内联块跑到了下一行，很奇怪。查其原因竟是：空格、换行造成的。

<!-- more -->

Stack Overflow 中的相似问题：

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Width issue</title>
    <style type="text/css">
      body {
        margin: 0;
      }
      #left {
        width: 50%;
        background: lightblue;
        display: inline-block;
      }
      #right {
        width: 50%;
        background: orange;
        display: inline-block;
      }
    </style>
  </head>
  <body>
    <div id="left">Left</div>
    <div id="right">Right</div>
  </body>
</html>
```

JSFiddle: [http://jsfiddle.net/5EcPK/](http://jsfiddle.net/5EcPK/)

1. 当减小一个 `inline-block` 的 width 为 49% 时，divs 可以并列显示，但是之间有个空隙，显然这不是一个理想的解决方案 [http://jsfiddle.net/mUKSC/](http://jsfiddle.net/mUKSC/)
2. 当将两个 divs 浮动时，也解决了这个问题 [http://jsfiddle.net/VptQm/](http://jsfiddle.net/VptQm/) 但是浮动布局并不是一个理想的布局方案，浮动属性本意是为了解决“文字环绕”的效果，浮动属性现在被滥用了

## 根本原因

When using `inline-block` elements, there will always be an `whitespace` issue between those elements (that space is about ~ 4px wide).

So, your two `divs`, which both have 50% width, plus that `whitespace`(~ 4px) is more than 100% in width, and so it breaks.

## 解决方案

### 移除 inline-block 之间的空格

```html
<div id="left">Left</div>
<div id="right">Right</div>
```

不推荐，太依靠代码格式

### 利用 HTML 注释

```html
<div id="left">Left</div>
<!--
-->
<div id="right">Right</div>
```

不推荐，很奇怪的代码格式

### 利用闭合标签

```
<div class="left">foo</div
><div class="right">bar</div>
```

```
<ul>
  <li class="left">foo
  <li class="right">bar
</ul>
```

不推荐，利用代码格式的感觉都不太靠谱

### 设置父级元素的 font-size 为 0

```css
.parent {
  font-size: 0; /* parent value */
}
.parent > div {
  display: inline-block;
  width: 50%;
  font-size: 1rem; /* 1 root em*/
}
```

### 使用负 margin 值

```css
div {
  display: inline-block;
  width: 50%;
  margin-right: -4px; /* negative margin */
}
```

> References:
>
> - [html - Two inline-block elements, each 50% wide, do not fit side by side in a single row - Stack Overflow](https://stackoverflow.com/questions/18262300/two-inline-block-elements-each-50-wide-do-not-fit-side-by-side-in-a-single-row)
> - [Fighting the Space Between Inline Block Elements | CSS-Tricks](https://css-tricks.com/fighting-the-space-between-inline-block-elements/)
