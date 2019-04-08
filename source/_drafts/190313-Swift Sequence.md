---
title: Swift Sequence
permalink: swift-sequence
date: 2019-03-13 10:00:00
updated: 2019-03-13 10:00:00
comments: true
toc: true
tags:
   - ios
   - swift
categories:
description:
---

开始探索 Swift，真正的去了解她。本文主要针对 `sequence` 这个协议，以及相关点。

> 环境：Swift 4.2

A type that provides sequential, iterated access to its elements. 一种类型，提供对元素的顺序迭代访问。

`for-in loop` 是最常见的迭代 sequence 元素的方法：

```
let oneTwoThree = 1...3
for number in oneTwoThree {
    print(number)
}
```

<!-- more -->


- 重复访问 Repeated Access. sequence 可以被多次迭代，而且不会被消耗。































r
