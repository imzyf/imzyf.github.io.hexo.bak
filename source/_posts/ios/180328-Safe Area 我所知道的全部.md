---
title: iOS Safe Area 我所知道的全部
permalink: ios-safe-area
date: 2018-03-29 11:00:00
updated: 2018-03-29 11:00:00
comments: true
toc: true
tags:
  - ios
categories:
description:
---

在 iOS 7 Apple 在 UIViewController 中引入了 `topLayoutGuide` 和 `bottomLayoutGuide` 属性来描述没有被覆盖(status bar, navigation bar, toolbar, tab bar, etc.)屏幕的区域。在 iOS 11 中，Apple 已经弃用了这些属性，并引入了 safe area。Apple 建议我们不要在 safe area 操作，在 iOS 11 中，当在 iOS App 中定位视图时，你必须使用新的 safe area API。

## UIView

在 iOS 11 UIViewController `topLayoutGuide` 和 `bottomLayoutGuide` 属性已经被替换成了新的 UIView 中的 safe area：

```
@available(iOS 11.0, *)
open var safeAreaInsets: UIEdgeInsets { get }

@available(iOS 11.0, *)
open var safeAreaLayoutGuide: UILayoutGuide { get }
```

`safeAreaInsets` 属性意味着屏幕可以覆盖从四个方向，而不仅仅是顶部和底部。当被 iPhone X 呈现时，我们就明白了为什么我们需要左右 insets。

<img src="https://tva1.sinaimg.cn/large/006tNbRwly1fptmugww5wj30zs0x0jw8.jpg" alt="ios-safe-area" width="400" />

_iPhone 8 vs iPhone X safe area (portrait orientation)_

<!-- more -->

<img src="https://tva1.sinaimg.cn/large/006tNbRwly1fptmv9csg7j30z0152ae6.jpg" alt="ios-safe-area" width="400" />

_iPhone 8 vs iPhone X safe area (landscape orientation)_

iPhone X 在 portrait orientation 有 top 和 bottom 的 safe area，在 landscape orientation 有 left right 和 bottom。

让我们来看一个例子。在 ViewController 的 View 的顶部和底部添加了两个带有文本标签和固定高度的 custom subviews，并附加 attached 到视图的边缘 edges。

<img src="https://tva1.sinaimg.cn/large/006tNbRwly1fptnobrau6j30no14i13p.jpg" alt="ios-safe-area" width="300" />

_Subviews are attached to the view’s edges_

正如所看到的，subviews 内容与顶部的 notch 和底部的 home indicator 指示器重叠 overlapped。为了正确地定位 subviews，我们可以使用手动布局将它们附加到 safe area：

```
topSubview.frame.origin.x = view.safeAreaInsets.left
topSubview.frame.origin.y = view.safeAreaInsets.top
topSubview.frame.size.width = view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right
topSubview.frame.size.height = 300
```

或者使用 Auto Layout：

```
bottomSubview.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
bottomSubview.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
bottomSubview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
bottomSubview.heightAnchor.constraint(equalToConstant: 300).isActive = true
```

<img src="https://tva1.sinaimg.cn/large/006tNbRwly1fptqg9si13j30no14iwq1.jpg" alt="ios-safe-area" width="300" />

_Subviews are attached to the superview safe area_

上面看起来好很多。此外可以在 subview subclass 添加 subviews content 到 safe area。

<img src="https://tva1.sinaimg.cn/large/006tNbRwly1fptquigdxjj30no14iqdh.jpg" alt="ios-safe-area" width="300" />

_Subviews are attached to the view’s edges. Labels are attached to the superview safe area._

在 subviews 层次结构 hierarchy 的任何地方都可以将 view 添加到 safe area。

## UIViewController

在 iOS 11 UIViewController 有了一个新属性：

```
@available(iOS 11.0, *)
open var additionalSafeAreaInsets: UIEdgeInsets
```

当 view controller subviews 覆盖嵌入的 child view controller views 时，将使用它。例如，Apple 在 UINavigationController 和 UITabBarController 中使用额外的 additional safe area insets，当这些条是半透明的。

`additionalSafeAreaInsets` 是对现有 safearea 的扩展附加。

当你改变 additional safe area insets 或者 safe area insets 被系统改变，UIView 和 UIViewController 中的方法将被调用：

```
// UIView
@available(iOS 11.0, *)
open func safeAreaInsetsDidChange()

//UIViewController
@available(iOS 11.0, *)
open func viewSafeAreaInsetsDidChange()
```

### Simulate iPhone X safe area

Additional safe area insets 也可以用来测试你的 app 是如何支持 iPhone X，如果你不能在模拟器上测试你的 app，而且没有 iPhone X，那就很有用了。

```
//portrait orientation, status bar is shown
additionalSafeAreaInsets.top = 24.0
additionalSafeAreaInsets.bottom = 34.0

//portrait orientation, status bar is hidden
additionalSafeAreaInsets.top = 44.0
additionalSafeAreaInsets.bottom = 34.0

//landscape orientation
additionalSafeAreaInsets.left = 44.0
additionalSafeAreaInsets.bottom = 21.0
additionalSafeAreaInsets.right = 44.0
```

<img src="https://tva1.sinaimg.cn/large/006tNc79ly1fpw2l9aa64j31kw0z0q9t.jpg" alt="ios-safe-area" width="400" />

## UIScrollView

> 待续

## Refereneces

- [iOS Safe Area](https://medium.com/rosberryapps/ios-safe-area-ca10e919526f)
