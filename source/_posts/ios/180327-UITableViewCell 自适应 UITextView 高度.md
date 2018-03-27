---
title: UITableViewCell 自适应 UITextView 高度
permalink: self-sizing-uitextview-in-a-uitableviewcell
date: 2018-03-27 16:00:00
updated: 2018-03-27 16:00:00
comments: true
toc: true
tags:
   - ios
categories:
description:
---

使用 Auto Layout 让 UITableViewCell 自适应 UITextView 高度，效果演示：

<img src="https://user-images.githubusercontent.com/9289792/37953137-931860e0-31d4-11e8-8809-c871b09f9519.gif" alt="Self-sizing UITextView in cell" width="200" />

[99-projects-of-swift/029-tableviewcell-self-adaption](https://github.com/imzyf/99-projects-of-swift/tree/master/029-tableviewcell-self-adaption)

<!-- more -->

## 预备步骤

1. 给 textView 上下左右建立相对于 cell 的约束
2. 取消 textView 的 `Scrolling Enabled`
3. 设置 tableView 估算高度 `tableView.estimatedRowHeight = 70`
4. 设置 `textView.delegate = self`

## 关键点

如果在 `textViewDidChange(textView:)` 调用 `tableView.reloadData()` 会造成 textView 失去焦点，键盘隐藏。

解决方法：

```
func textViewDidChange(textView: UITextView) {
    tableView.beginUpdates()
    tableView.endUpdates()
}
```

这里带来了一个问题，当 textView 长度超过一屏或者过长时，在输入时 tableView 会跳动滚动 jumping and stuttering。

更好的解决方法：

```
func textViewDidChange(textView: UITextView) {
    let currentOffset = tableView.contentOffset
    UIView.setAnimationsEnabled(false)
    tableView.beginUpdates()
    tableView.endUpdates()
    UIView.setAnimationsEnabled(true)
    tableView.setContentOffset(currentOffset, animated: false)
}
```

disabling animations and re-setting the contentOffset of the table view fixes the stuttering.

> Reference:
> - [Self-sizing UITextView in a UITableView using Auto Layout - like Reminders.app](http://candycode.io/self-sizing-uitextview-in-a-uitableview-using-auto-layout-like-reminders-app/)
