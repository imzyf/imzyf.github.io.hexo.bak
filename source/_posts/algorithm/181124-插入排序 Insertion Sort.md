---
title: 插入排序 Insertion Sort
permalink: insertion-sort
date: 2018-11-24 16:00:00
updated: 2018-11-24 16:00:00
comments: true
toc: true
tags:
   - swift
   - algorithm
categories:
description:
---

<img src="https://ws2.sinaimg.cn/large/006tKfTcly1g0m5wy6fuwj31y10u04qs.jpg" alt="queue-data-structure" />

将一个数组从高到低或者从低到高排序。

插入排序算法的工作原理：

1. 将若干数字放在一个数组里，数组是乱序的。
2. 从数组中挑选一个数字，它是哪个并不重要，但是为了方便我们挑选数组头部的这个。
3. 将这个数字插入到一个新的数组里。
4. 从乱序数组里挑选下一个数字也将它放到新数组里。这个数字要么在第一个数字前或者后，所以这个两个数字是被排序的。
5. 再次重从乱序数组里挑选下一个数字也将它放到新数组里，并将数字放在正确的位置。
6. 一直如此进行直到乱序数组中没有数字。这时也将等到一个排序好的新数组。

<!-- more -->

自己的一个实现：

```
let array = [2, 1, 3, 8, 3, 5, 4]

var newArray = [Int]()
for (k, v) in array.enumerated() {
    for (nK, nV) in newArray.enumerated() {
        // 本次的数 小于 存在的数的第一个(nv)
        if v < nV {
            newArray.insert(v, at: nK)
            break
        }
    }
    // 没有插入成功 放在末尾
    if newArray.count < k + 1 {
        newArray.append(v)
    }
}
```

## In-place sort

上面的排序需要两个数组，一个原始的，一个排好顺序的。但是我们也可以 *就地排序* 无需创建一个额外的数组。我们只需要跟踪记录原始数组中哪里部分排好顺序了，哪一部分还没有排序。

举例：`[ 8, 3, 5, 4, 6 ]` 使用 `|` 分割是否排好顺序的部分。

```
// 开始时 | 在最前
[| 8, 3, 5, 4, 6 ]

// 开始向左移动，左侧只有个 8 无论什么顺序都是正确的，右侧是未排序的部分
[ 8 | 3, 5, 4, 6 ]

// 依次进行 将未排序的头部元素放在已排部分的正确位置
[ 3, 8 | 5, 4, 6 ]
[ 3, 5, 8 | 4, 6 ]
[ 3, 4, 5, 8 | 6 ]
[ 3, 4, 5, 6, 8 |]  
```

每次 `|` 移动，都对左侧进行排序，未排序的部分逐渐减少，排序部分增加。直到未排序部分为零。

## How to insert

将未排序的头部元素放在已排部分的正确位置，如何这到这点的？

```
// 从此状态开始。下个说的 4，我们需要将 4 插入到 [ 3, 5, 8 ] 这个已经排好的数组里
[ 3, 5, 8 | 4, 6 ]

// 移动 |，这时我们注意 8 这个元素
[ 3, 5, 8, 4 | 6 ]
        ^

// 8 大于 4，所有 8 应该在 4 的右边，8 与 4 进行位置调换
[ 3, 5, 4, 8 | 6 ]
        <-->
      swapped

// 将 4 与现在的前面的元素 5 进行比较，5 大于 4，所以 5 与 4 进行位置调换
[ 3, 4, 5, 8 | 6 ]
     <-->
    swapped

// 3 小于 4 这个数，所以我们完成了对 4 的排序，这时从头到 |，是排好顺序的
[ 3, 4, 5, 8 | 6 ]
```

这就是对插入排序算法的内循环的描述。

## The code

```
func insertionSort(_ array: [Int]) -> [Int] {
    // 1
    var a = array
    // 2
    for x in 1..<a.count {
        var y = x
        // 3
        while y > 0 && a[y] < a[y - 1] {
            a.swapAt(y - 1, y)
            y -= 1
        }
    }
    return a
}
```

1. 将 `array` 复制一个副本。因为我们无法直接修改参数中的 `array`，就想 Swift 自身的 `sort()`，`insertionSort()` 将返回一个排序顺序的副本数组。
2. 两个循环在方法中。外层循环遍历轮到排序的元素，也就是从待排数组中挑选出头部的元素。`x` 索引为排好顺序的结尾索引同时也是待排数组的开头。记住，如何时间从开头到 `x` 永远都是排好顺序的，从 `x` 到最后的元素都是未排序的。
3. 内层循环查询 x 索引位置的元素。这个元素可能小于之前排序顺序数组中的每一个元素。内层循环从后倒序遍历每一个已排序的元素，每次发现这个元素之前的元素比它大，则交互位置。当内层循环完成时，数组从开头到 x 将又是已排序的。

tip：外层循环从索引 1 开始，而不是 0。将第一个元素从堆移动到排序部分实际上并没有改变任何东西，所以我们不妨跳过它。

## No more swaps

上面的插入排序可以正常的工作了。我们还可以通过移除调用 swap() 让程序更快一些。

我们可以将所有需要换位置的元素向右移动一个位置，然后将新数字复制到正确的位置。

```
[ 3, 5, 8, 4 | 6 ]   remember 4
           *

[ 3, 5, 8, 8 | 6 ]   shift 8 to the right
        --->

[ 3, 5, 5, 8 | 6 ]   shift 5 to the right
     --->

[ 3, 4, 5, 8 | 6 ]   copy 4 into place
     *
```

```
func insertionSort(_ array: [Int]) -> [Int] {
    var a = array
    for x in 1..<a.count {
        var y = x
        let temp = a[y]
        // tip
        while y > 0 && temp < a[y - 1] {
            // 1
            a[y] = a[y - 1]                
            y -= 1
        }
        // 2
        a[y] = temp                      
    }
    return a
}
```

1. 原本需要换位置的元素右移一个位置。
2. 当内层结束时，`y` 的索引位置就是新元素的排序后的位置，将元素放在此。

tip：这里我自己写成了 `while y > 0 && a[y] < a[y - 1]` 这是不对的，因为我要找的是 **原本** 的 `a[y]` 的位置，但是循环一次后 `a[y]` 将发生变化。

## Making it generic

```
func insertionSort<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    var a = array
    for x in 1..<a.count {
        var y = x
        let temp = a[y]
        while y > 0, isOrderedBefore(temp, a[y - 1])  {
            a[y] = a[y - 1]
            y -= 1
        }
        a[y] = temp
    }

    return a
}
```

通过闭包来执行大小比较。

```
let numbers = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
insertionSort(numbers, <)

let objects = [ obj1, obj2, obj3, ... ]
insertionSort(objects) { $0.priority < $1.priority }
```

插入排序是一种稳定 `stable` 的排序。当排序后具有相同排序键的元素保持相同的相对顺序时，排序是稳定的。这对于诸如数字或字符串之类的简单值并不重要，但在排序更复杂的对象时这很重要。在上面的示例中，如果两个对象具有相同的优先级，则无论其他属性的值如何，这两个对象都不会被交换。

## Performance

最差的插入排序是 `O(n^2)` 因为俩个相近的循环嵌套。其他排序算法（如快速排序和合并排序）具有 `O(n log n)` 性能，在大输入时速度更快。

插入排序实际上对于排序小数组非常快。某些标准库具有排序功能，当分区大小为 `10` 或更小时，可以从快速排序切换到插入排序。

将 `insertSort()` 与 Swift 的内置 `sort()` 进行比较。在大约 `100` 元素左右的阵列上，速度差异很小。但是，随着输入变大，`O(n^2)` 快速开始执行比 `O(n log n)` 差很多，并且插入排序无法跟上。

文章代码：[GitHub - imzyf/data-structure-and-algorithm/003-Insertion Sort/](https://github.com/imzyf/data-structure-and-algorithm/tree/master/003-Insertion%20Sort)。

> Reference:
> - [raywenderlich/swift-algorithm-club/Insertion Sort](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Insertion%20Sort)
