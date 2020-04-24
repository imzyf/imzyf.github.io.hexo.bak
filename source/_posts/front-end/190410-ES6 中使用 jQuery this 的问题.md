---
title: ES6 中使用 jQuery $(this) 的问题
permalink: es6-jquery-this-arrow-function
date: 2019-04-10 17:09:23
updated: 2019-04-10 17:09:32
tags:
  - js
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1562184242-2b39bde0ab6f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=640&q=80
feature_img:
---

在老项目中开始改用 `laravel-mix` `ES6` 逐渐过渡。摸索中遇到在与 `jQuery` 一同使用时 `箭头函数` 中 `$(this)` 的含义发生了变化。

<!-- more -->

遇到这个问题主要是没有搞清楚 [箭头函数](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/Arrow_functions)：

```js
$('.js-bottom-btn').click(() => {
    let flag = $(this).date('flag');
    ...
});
```

转换为了：

```js
$('.js-bottom-btn').click(function() {
    let flag = $(_this).date('flag');
    ...
});
```

`_this` is undefined

根据 [jQuery click 文档](https://api.jquery.com/click/) 可以修改为：

```js
$('.js-bottom-btn').click(event => {
    let flag = $(event.currentTarget).date('flag');
    ...
});
```

类似的问题：

```js
$("jquery-selector").each(() => {
  $(this).click();
});
```

需要改为：

```js
$("jquery-selector").each((index, element) => {
  $(element).click();
});
```

## References:

- [Using jQuery \$(this) with ES6 Arrow Functions (lexical this binding)](https://stackoverflow.com/questions/27670401/using-jquery-this-with-es6-arrow-functions-lexical-this-binding)

-- EOF --
