---
title: 【Swifter - Swift 开发者必备 Tips】笔记
permalink: swifter-tips-reading-notes
date: 2019-02-15 17:00:00
updated: 2019-02-15 17:00:00
comments: true
toc: true
tags:
  - ios
  - swift
  - reading-notes
categories:
description:
---

再读王巍的【Swifter - Swift 开发者必备 Tips】，看看有什么新收获。

## 柯里化（Currying）

[柯里化](https://zh.wikipedia.org/wiki/%E6%9F%AF%E9%87%8C%E5%8C%96]) 是把接受多个参数的函数变换成接受一个单一参数（最初函数的第一个参数）的函数，并且返回接受余下的参数而且返回结果的新函数的技术，这个词自己是第一次见到。

自己的理解就是：把接受多个参数的函数变换为，先接受一个参数，然后返回一个函数，这个函数再接受其他参数。

两个细节：

- 只有一个参数，并且这个参数是该函数的第一个参数。必须按照参数的定义顺序来调用柯里化函数。
- 柯里化函数的函数体只会执行一次，只会在调用完最后一个参数的时候执行柯里化函数体。

<!-- more -->

```
/// 一个数加 x 的函数
func addTo(_ adder: Int) -> (Int) -> Int {
    return { adder + $0 }
}
// +2
let addTwo = addTo(2)
let result = addTwo(6) // 8

// +10
let addTen = addTo(10)
addTen(6) // 16
```

柯里化是一种量产相似方法的好办法，可以通过柯里化一个方法模板来避免写出很多重复代码，也方便了今后维护。

书中还提到了一个封装 [Selector](https://oleb.net/blog/2014/07/swift-instance-methods-curried-functions/?utm_campaign=iOS_Dev_Weekly_Issue_157&utm_medium=email&utm_source=iOS%252BDev%252BWeekly) 的例子，但是没懂，欢迎指教。

> Reference:
>
> - [Swift 函数柯里化介绍及使用场景](https://www.jianshu.com/p/5b27fec8c616)

## 将 protocol 的方法声明为 mutating

`protocol` 不仅可以被 `class` 类型实现，也适用于 `struct` 和 `enum`。因为这个原因就要考虑定义的方法是否应该使用 `mutating` 来修饰。在 `protocl` 中使用 `mutating` 修饰的方法，对于 `class` 的实现是完全透明的。

## 多元组（Tuple）

python 中有见过类似。

```
/// 交互数据
func swapMe<T>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}

var a = 10
var b = 20
swapMe(&a, &b) // a: 20  b: 10
```

```
/// 可读的返回值
let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
let (slice, remainder) = rect.divided(atDistance: 20, from: .minYEdge)

// slice {x 0 y 0 w 100 h 20}
// remainder {x 0 y 20 w 100 h 80}
```

## `@autoclosure` 和 `??`

`@autoclosure` 做的事情就是把一句表达式自动的封装成一个闭包（closure）。这样有时候在语法上看起来就会非常漂亮。

```
func logIfTrue(_ predicate: @autoclosure () -> Bool) {
    if predicate() {
        print("True")
    }
}

logIfTrue(2 > 1)
// 而不是 logIfTrue { 2 > 1 }
```

Swift 把 `2 > 1` 这个表达式自动转换为 `() -> Bool`。

Swift 中 `??` 定义为：

```
func ??<T>(optional: T?, defaultValue: @autoclosure () -> T?) -> T?

func ??<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T
```

```
/// 猜测 ?? 的实现
func ??<T>(optional: T?, defaultValue: @autoclosure() -> T) -> T {
    switch optional {
    case .some(let value):
        return value
    default:
        return defaultValue()
    }
}
```

使用 `@autoclosure` 来修饰默认值看起来有些画蛇添足，但是如果默认值是通过一系列复杂计算得到话，在 optional 不为 `nil` 的情况下就会造成浪费。`@autoclosure` 将计算推迟到 `optional` 为 `nil`。

## `@escaping`

```
func doWork(block: () -> Void) {
    block()
}

doWork {
    print("work")
}
```

这里默认了一个隐藏假设：参数中 `block` 的内容会在 `doWork` 发会之前就完成了，也就是说，对于 `block` 的调用是同步行为。

```
func doWorkAsync(block: @escaping () -> ()) {
    DispatchQueue.main.async {
        block()
    }
}
```

`@escaping` 表明这个闭包是会 **逃逸** 出该方法。

```

class S {
    var foo = "foo"

    func method1() {
        doWork {
            print(foo)
        }
        foo = "method1"
    }
    func method2() {
        doWorkAsync {
            print(self.foo)
        }
        foo = "method2"
    }
    func method3() {
        foo = "method4"
        doWorkAsync { [weak self] in
            print(self?.foo ?? "nil")
        }
        foo = "method3"
    }
}

S().method1()  // foo - 同步
S().method2()  // method2 - 强引用造成？
S().method3()  // nil - 已经释放
```

## Optional Chaining

```
let playClosure = { (child: Child) -> Void in
    child.pet?.toy?.play()
}
```

这里 `Void` 是不合理的，因为真正的结果是一个 `Optional` 的结果，所有应该为 `Void?`。

```
let playClosure = { (child: Child) -> Void? in
    child.pet?.toy?.play()
}

// 判断方法是否调用成功：
if let result = playClosure {
    print("happy")
} else {
    print("can't play")
}
```
