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

<img src="https://ws3.sinaimg.cn/large/006tKfTcly1g0me5rnttbj31xz0u01l0.jpg" alt="promisekit-getting-started" />

在 GitHub Trending 中总是看到 [mxcl/PromiseKit](https://github.com/mxcl/PromiseKit) 它是主要解决的是 “回调地狱” 的问题，决定尝试用一下。

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

如果这段代码使用完成回调（completion handler）实现，他将是：

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

then 是完成回调的另一种方式，但是它更丰富。在处级阶段的理解，它更具有可读性。上面的 promise chain 更容易阅读和理解：一个异步操作接着另一个，一行接一行。它与程序代码非常接近，因为我们很容易得到 Swift 的当前状态。

done 与 then 基本是一样的，但是它将不再返回 promise。它是典型的在末尾 “success” 部分的 chain。在上面的例子 done 中，我们接收到了最终的图片并使用它设置了 UI。

让我们对比一下两个 login 的方法签名：

```
// Promise:
func login() -> Promise<Creds>

// Compared with:
func login(completion: (Creds?, Error?) -> Void)
                    // 可选型，两者都是可选
```

区别在于 promise，方法返回 promises 而不是的接受和运行回调。每一个处理器（handler）都会返回一个 promise。Promise 对象们定义 then 方法，该方法在继续链式调用之前等待 promise 的完成。chains 在程序上解决，一次一个 promise。

Promise 代表未来异步方法的输入值。它有一个表示它包装的对象类型的类型。例如，在上面的例子里，login 的返回 Promise 值代表一个 Creds 的一个实例。

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

每个 promise 都是一个表示单个（individual）异步任务的对象。如果任务失败，它的 promise 将成为 rejected。产生 rejected promises 将跳过后面所有的 then，而是将执行 catch。（严格上说是执行后续所有的 catch 处理）

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

使用 guard 和合并错误对处理有所保证，但是 promise chain 更具有可读性。

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

无论在 chain 哪里结束，成功或者失败，ensure 终将被执行。也可以使用 finally 来完成相同的事情，区别是没有返回值。

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





> Reference:
> - [Getting Started](https://github.com/mxcl/PromiseKit/blob/master/Documentation/GettingStarted.md)
