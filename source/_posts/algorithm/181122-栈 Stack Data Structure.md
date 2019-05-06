---
title: 栈 Stack Data Structure
permalink: stack-data-structure
date: 2018-11-22 14:00:00
updated: 2018-11-22 14:00:00
comments: true
toc: false
tags:
   - swift
   - algorithm
categories:
description:
---
 
<img src="https://cdn-qn.yifans.com/imzyf/johnson-wang-20675-unsplash.jpg" alt="queue-data-structure" />

加入 [Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club) /'ælgə'rɪðəm/，回炉重新学习数据结构与算法。

自己创建的项目：[GitHub - imzyf/data-structure-and-algorithm](https://github.com/imzyf/data-structure-and-algorithm)。

实现一个 `栈` /stæk/，包含 `push` `peek` `pop` 与 `Generics` 泛型。

<!-- more -->

## stack

`栈` 非常像一个数组，它包括少量的方法。

- push 添加一个新元素到栈顶
- pop 从栈顶移除一个元素
- peek 查看栈顶的一个元素但是不 pop

A stack gives you a LIFO or last-in first-out order. 栈是后进先出，队列是先进先出。

```
public struct Stack<Element> {
    fileprivate var array: [Element] = []
}
```

## push

`push` 是在数组的尾部添加元素是以 `O(1)`，如果是在数组最前添加是 `O(n)` 这是昂贵的。

```
public mutating func push(_ element: Element) {
  array.append(element)
}
```

因为使用的 `struct`，修改属性值的方法要加 `mutating`。

## pop

想从一个空栈中弹出最后一个元素将返回 `nil`。

```
public mutating func pop(_ element: Element) {
    return array.popLast()
}
```

## peek

与 `pop` 有点像，但是并没有移除栈顶的元素。

```
/// peek 改为更加语义化的 top 只读变量
public var top: T? {
    return array.last
}
```

## other

两个其他的常用属性，栈是否为空，栈中元素的个数。

```
public var isEmpty: Bool {
  return array.isEmpty
}

public var count: Int {
  return array.count
}
```

> Reference:
> - [Swift Algorithm Club: Swift Stack Data Structure](https://www.raywenderlich.com/800-swift-algorithm-club-swift-stack-data-structure)
