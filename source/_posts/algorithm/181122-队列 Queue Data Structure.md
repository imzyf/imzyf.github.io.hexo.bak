---
title: 队列 Queue Data Structure
permalink: queue-data-structure
date: 2018-11-22 16:00:00
updated: 2018-11-22 16:00:00
comments: true
toc: true
tags:
   - swift
   - algorithm
categories:
description:
---

实现一个 `队列`，包括 `enqueue`、`dequeue`、`peek`。

## Queue

`队列` 核心也是 array，A queue gives you a FIFO or first-in, first-out order. 队列是：先进先出的。

```
public struct Queue<T> {    
    fileprivate var array = [T]()
}
```

<!-- more -->

## enqueue

进队，在数组尾部追加元素。

```
public mutating func enqueue(_ element: T) {
    array.append(element)
}
```

## dequeue

出队，将首位的元素移除。因为首位元素移除后，其他元素依次向前移动，所以是 O(n)。

```
public var isEmpty: Bool {
    // 使用数组自身的方法，而不是 array.count > 0
    return array.isEmpty
}

public mutating func dequeue() -> T? {
    // 使用定义的变量
    if isEmpty {
        return nil
    } else {
        return array.removeLast()
    }
}
```

## peek

查看队首元素。

```
/// peek() 改为更有语义话的只读变量
public var front: T? {
    return array.first
}
```

## 优化出队

在出队后不移动元素而是移动 `起始索引`，就像动的收银台而不是排队的人。

```
/// 优化 队列 的出队
public struct OptimizedQueue<T> {

    /// 这里改为了可选型，为了可以清理无效的元素
    fileprivate var array = [T?]()
    /// 起始索引
    fileprivate var head = 0

    public var count: Int {
        // 减去 起始索引 前面的数量
        return array.count - head
    }

    public var isEmpty: Bool {
        // 根据实际数量判断
        return count == 0
    }

    // 保持不变
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }

    public mutating func dequeue() -> T? {
        guard head < array.count,
            let element = array[head] else {
            return nil
        }
        // 置空当前位置元素
        array[head] = nil
        // 前移起始索引
        head += 1

        // 空索引的占用比例
        let percentage = Double(head)/Double(array.count)
        // 50 0.25 都是魔法数字，主要是为了控制数组修剪的频率，可以自行调整
        if array.count > 50 && percentage > 0.25 {
            // 将起始空元素删除
            array.removeFirst(head)
            // 重置 起始索引
            head = 0
        }

        return element
    }

    public var front: T? {
        if isEmpty {
            return nil
        } else {
            // 根据 起始索引进行 返回
            return array[head]
        }
    }
}
```

文章代码：[GitHub - imzyf/data-structure-and-algorithm/002-Queue/](https://github.com/imzyf/data-structure-and-algorithm/tree/master/002-Queue)。

> Reference:
> - [raywenderlich/swift-algorithm-club/Queue](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Queue)
