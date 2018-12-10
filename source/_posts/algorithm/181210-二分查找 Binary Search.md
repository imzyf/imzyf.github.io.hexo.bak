---
title: 二分查找 Binary Search
permalink: binary-search
date: 2018-12-10 14:00:00
updated: 2018-12-10 14:00:00
comments: true
toc: true
tags:
   - swift
   - algorithm
categories:
description:
---

快速从一个数组中查找一个元素。

## Linear Search 线性查找

```
func linearSearch<T: Equatable>(_ a: [T], _ key: T) -> Int? {
    for i in 0 ..< a.count {
        if a[i] == key {
            return i
        }
    }
    return nil
}
```

线性查找在最坏情况：遍历了整个数组，但没有找到合适的元素。平均要遍历一半的元素性能为 `O(n)`，而二分查找的效率为 `O(log n)`，也就是说一个有 `1,000,000` 元素的数组只需要 `20` 步就可以找到想要的元素 `log_2(1,000,000) = 19.9`。

<!-- more -->

但是二分查找要求数组必须是排好序。

二分查找步骤：

1. 将数组分为两半。
2. 判断想要找的元素是在左边数组还是右边，这也是数组需要排好顺序的原因。
3. 如果要的元素在左边，就将左边的数组分成更小的两部分，并判断要的元素在哪部分。
4. 重复步骤直到找到想要的元素。如果数组不能进一步查分，就说明要找的元素不在数组中。

divide-and-conquer

## The code

```
func binarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        // If we get here, then the search key is not present in the array.
        return nil

    } else {
        // Calculate where to split the array.
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2

        // Is the search key in the left half?
        if a[midIndex] > key {
            return binarySearch(a, key: key, range: range.lowerBound ..< midIndex)

        // Is the search key in the right half?
        // 这里 + 1 的原因是排除 midIndex 中间值
        } else if a[midIndex] < key {
            return binarySearch(a, key: key, range: midIndex + 1 ..< range.upperBound)

        // If we get here, then we've found the search key!
        } else {
            return midIndex
        }
    }
}
```

```
// 19 numbers
let numbers = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]

// 0 ..< numbers.count 覆盖所有范围
binarySearch(numbers, key: 43, range: 0 ..< numbers.count)  // gives 13
```

二分查找是将数组分为两个，但是我们不需要正真的创建两个新数组。取而代之，我们使用 Swift `Range` 对象跟踪这些拆分。左闭右开。upperBound 总是比最后一个元素的索引多一。

```
midIndex = (lowerBound + upperBound) / 2
```

如果这样写将存在一个 bug，就是当这两值非常大时，将存在一个越界的问题。

## Iterative vs recursive 迭代 vs 递归

二分查找本质是递归。

使用迭代的方式实现：

```
func binarySearch(_ a: [Int], key: Int) -> Int? {
    var lowerBound = 0
    var upperBound = a.count
    while lowerBound < upperBound {
        // 这行僵硬了 没有必要的
        var range = lowerBound ..< upperBound
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        let midValue = a[midIndex]
        if key < midValue {
            upperBound = midIndex
        } else if key > midValue {
            lowerBound = midIndex + 1
        } else {
            return midIndex
        }
    }
    return nil
}
```

## The end

查找前数组一定要先排序吗？这取决于排序花费的时间，有时候：数组排序加二分查找比线性搜索还要慢。二分查找的优势在于一次排序后多次查找。

文章代码：[GitHub - imzyf/data-structure-and-algorithm/004-Binary Search/](https://github.com/imzyf/data-structure-and-algorithm/tree/master/004-Binary%20Search)。

> Reference:
> - [raywenderlich/swift-algorithm-club/Binary Search](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Search)
