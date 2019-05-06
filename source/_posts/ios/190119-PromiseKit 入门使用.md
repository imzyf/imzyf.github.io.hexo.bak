---
title: PromiseKit 入门使用
permalink: promisekit-getting-started
date: 2019-01-19 14:00:00
updated: 2019-01-19 14:00:00
comments: true
toc: true
tags:
   - ios
categories:
description:
---

<img src="https://cdn-qn.yifans.com/imzyf/rawpixel-1054574-unsplash.jpg" alt="promisekit-getting-started" />

在 GitHub Trending 中总是看到 [mxcl/PromiseKit](https://github.com/mxcl/PromiseKit) 它是主要解决的是 “回调地狱” 的问题，决定尝试用一下。

> 环境：Swift 4.2、PromiseKit 6

## then and done

下面是一个典型的 promise 链式（chain）调用：

```
firstly {
    login()
}.then { creds in
    fetch(avatar: creds.user)
}.done { image in
    self.imageView = image
}
```

<!-- more -->

如果这段代码使用完成回调（`completion handler`）实现，他将是：

```
login { creds, error in
    if let creds = creds {
        fetch(avatar: creds.user) { image, error in
            if let image = image {
                self.imageView = image
            }
        }
    }
}
```

`then` 是完成回调的另一种方式，但是它更丰富。在处级阶段的理解，它更具有可读性。上面的 promise chain 更容易阅读和理解：一个异步操作接着另一个，一行接一行。它与程序代码非常接近，因为我们很容易得到 Swift 的当前状态。

`done` 与 `then` 基本是一样的，但是它将不再返回 promise。它是典型的在末尾 “success” 部分的 chain。在上面的例子 `done` 中，我们接收到了最终的图片并使用它设置了 UI。

让我们对比一下两个 `login` 的方法签名：

```
// Promise:
func login() -> Promise<Creds>

// Compared with:
func login(completion: (Creds?, Error?) -> Void)
                    // 可选型，两者都是可选
```

区别在于 promise，方法返回 promises 而不是的接受和运行回调。每一个处理器（handler）都会返回一个 promise。Promise 对象们定义 `then` 方法，该方法在继续链式调用之前等待 promise 的完成。chains 在程序上解决，一次一个 promise。

Promise 代表未来异步方法的输入值。它有一个表示它包装的对象类型的类型。例如，在上面的例子里，`login` 的返回 Promise 值代表一个 Creds 的一个实例。

可以注意到这与 completion pattern 的不同，promises chain 似乎忽略错误。并不是这样，实际上：promise chain 使错误处理更容易访问（accessible），并使错误更难被忽略。

## catch

有了 promises，错误在 promise chain 上级联（cascade along），确保你的应用的健壮（robust）和清晰的代码。

```
firstly {
    login()
}.then { creds in
    fetch(avatar: creds.user)
}.done { image in
    self.imageView = image
}.catch {
    // 整个 chain 上的错误都到了这里
}
```

> 如果你忘记了 catch 这个 chain，Swift 会发出警告

每个 promise 都是一个表示单个（individual）异步任务的对象。如果任务失败，它的 promise 将成为 `rejected`。产生 `rejected` promises 将跳过后面所有的 `then`，而是将执行 `catch`。（严格上说是执行后续所有的 `catch` 处理）

这与 completion handler 对比：

```
func handle(error: Error) {
    //...
}

login { creds, error in
    guard let creds = creds else { return handle(error: error!) }
    fetch(avatar: creds.user) { image, error in
        guard let image = image else { return handle(error: error!) }
        self.imageView.image = image
    }
}
```

使用 `guard` 和合并错误对处理有所保证，但是 promise chain 更具有可读性。

## ensure

```
firstly {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    return login()
}.then {
    fetch(avatar: $0.user)
}.done {
    self.imageView = $0
}.ensure {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
}.catch {
    // ...
}
```

无论在 chain 哪里结束，成功或者失败，`ensure` 终将被执行。也可以使用 `finally` 来完成相同的事情，区别是没有返回值。

```swift
spinner(visible: true)

firstly {
    foo()
}.done {
    // ...
}.catch {
    // ...
}.finally {
    self.spinner(visible: false)
}
```

## when

多个异步操作同时处理时可能又难又慢。例如当 `操作1` 和 `操作2` 都完成时再返回结果：

```
// 串行操作
operation1 { result1 in
    operation2 { result2 in
        finish(result1, result2)
    }
}
```

```
// 并行操作
var result1: ...!
var result2: ...!
let group = DispatchGroup()
group.enter()
group.enter()
operation1 {
    result1 = $0
    group.leave()
}
operation2 {
    result2 = $0
    group.leave()
}
group.notify(queue: .main) {
    finish(result1, result2)
}
```

使人 Promises 将变得容易很多：

```
firstly {
    when(fulfilled: operation1(), operation2())
}.done { result1, result2 in
    // ...
}
```

`when` 等待所有的完成再返回 promises 结果。

## PromiseKit 扩展

PromiseKit 提过了一些 Apple API 的扩展，例如：

```
firstly {
    CLLocationManager.promise()
}.then { location in
    CLGeocoder.reverseGeocode(location)
}.done { placemarks in
    self.placemark.text = "\(placemarks.first)"
}
```

同时需要指定 subspaces：

```
pod "PromiseKit"
pod "PromiseKit/CoreLocation"
pod "PromiseKit/MapKit"
```

更多的扩展可以查询 [PromiseKit organization](https://github.com/PromiseKit)，甚至扩展了 [Alamofire](https://github.com/PromiseKit/Alamofire-) 这样的公共库。

## 制作 Promises

有时你的 chains 仍然需要以自己开始，或许你使用的三方库没有提供 promises 或者自己写了异步系统，没关系，他们非常容易添加 promises。如果你查看了 PromiseKit 的标准扩展，可以看到使用了下面相同的描述：

已有代码：

```
func fetch(completion: (String?, Error?) -> Void)
```

转换：

```
func fetch() -> Promise<String> {
    return Promise { fetch(completion: $0.resolve) }
}
```

更具有可读性的：

```
func fetch() -> Promise<String> {
    return Promise { seal in
        fetch { result, error in
            seal.resolve(result, error)
        }
    }
}
```

Promise 初始化程序提供的 `seal` 对象定义了很多处理 `garden-variety` 完成回调的方法。

> PromiseKit 设置尝试以 `Promise(fetch)` 进行处理，但是完成通过编译器的消歧义。

## Guarantee<T>

从 PromiseKit 5 开始，提供了 Guarantee 以做补充，目的是完善 Swift 强的的异常处理。

`Guarantee` 永远不会失败，所以不能被 `rejected`。

```
firstly {
    after(seconds: 0.1)
}.done {
    // 这里不要加 catch
}
```

`Guarantee` 的语法相较更简单：

```
func fetch() -> Promise<String> {
    return Guarantee { seal in
        fetch { result in
            seal(result)
        }
    }
}

// 减少为

func fetch() -> Promise<String> {
    return Guarantee(resolver: fetch)
}
```

## map compactMap 等

- `then` 要求返回另一个 promise
- `map` 要求返回一个 object 或 value 类型
- `compactMap` 要求返回一个 可选型，如过返回 `nil`，chain 将失败并报错 `PMKError.compactMap`

```
firstly {
    URLSession.shared.dataTask(.promise, with: rq)
}.compactMap {
    try JSONSerialization.jsonObject($0.data) as? [String]
}.done { arrayOfStrings in
    // ...
}.catch { error in
    // Foundation.JSONError if JSON was badly formed
    // PMKError.compactMap if JSON was of different type
}
```

除此之外还有：`thenMap` `compactMapValues` `firstValue` etc

## get

`get` 会得到 `done` 中相同值。

```
firstly {
    foo()
}.get { foo in
    // ...
}.done { foo in
    // same foo!
}
```

## tap

为 debug 提供 `tap`，与 `get` 类似但是可以得到 `Result<T>` 这样就可以检查 chain 上的值：

```
firstly {
    foo()
}.tap {
    print($0)
}.done {
    // ...
}.catch {
    // ...
}
```

## 补充

### firstly

上面例子中的 `firstly` 是语法糖，非必须但是可以让 chains 更有可读性。

```
firstly {
    login()
}.then { creds in
    // ...
}

// 也可以
login().then { creds in
    // ...
}
```

知识点：`login()` 返回了一个 `Promise`，同时所有的 `Promise` 有一个 `then` 方法。`firstly` 返回一个 `Promise`，同样 `then` 也返回一个 `Promise`。

### when 变种

- `when(fulfilled:)` 在所有异步操作执行完后才执行回调，一个失败 chain 将 rejects。It's important to note that all promises in the when continue. Promises have no control over the tasks they represent. Promises are just wrappers around tasks.
- `when(resolved:)` 使一个或多个组件承诺失败也会等待。此变体 `when` 生成的值是 `Result<T>` 的数组，所有要保证相同的泛型。
- `race` 只要有一个异步操作执行完毕，就立刻执行 `then` 回调。其它没有执行完毕的异步操作仍然会继续执行，而不是停止。

### Swift 闭包接口

Swift 有自动推断返回值和单行返回。

```
foo.then {
    bar($0)
}

// is the same as:

foo.then { baz -> Promise<String> in
    return bar(baz)
}
```

这样有好有坏，具体可以查询 [Troubleshooting](https://github.com/mxcl/PromiseKit/blob/master/Documentation/Troubleshooting.md)

## 更多阅读

- 强力建议阅读 [API Reference](https://mxcl.dev/PromiseKit/reference/v6/Classes/Promise.html)
- 在 Xcode 使用 optinon-click 阅读 PromiseKit 代码
- 在网上有一些 PMK < 5 的文章，里面的 API 有些不同要注意

> Reference:
>
> - [Getting Started](https://github.com/mxcl/PromiseKit/blob/master/Documentation/GettingStarted.md)
> - [Swift - 异步编程库 PromiseKit 使用详解 1（安装配置、基本用法）](https://www.hangge.com/blog/cache/detail_2231.html)

-- EOF --
