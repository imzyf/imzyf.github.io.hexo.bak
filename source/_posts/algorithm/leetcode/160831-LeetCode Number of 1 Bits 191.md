---
title: LeetCode Number of 1 Bits 191
permalink: leetcode-number-of-1-bits-191
comments: true
date: 2016-08-31 13:00:00
toc: true
tags:
   - leetcode
description:
---

[191. Number of 1 Bits](https://leetcode.com/problems/number-of-1-bits/)
&emsp;&emsp;Write a function that takes an unsigned integer and returns the number of ’1' bits it has (also known as the Hamming weight).
&emsp;&emsp;For example, the 32-bit integer ’11' has binary representation `00000000000000000000000000001011`, so the function should return 3.
<!-- more -->

---

### 大体意思
写一个函数，输入一个无符号整数，返回其中值为1的比特位的个数（这个值也被称为数字汉明重量）

### 自己的思路
循环判断最后一位是否是 `1`

``` java
public int hammingWeight(int n) {
	int result = 0;
	while (n != 0) {
		if ((n & 1) == 1) {
			result++;
		}
		n = n >> 1;
	}
	return result;
}
```
在 Submit Solution

```
Submission Result: Time Limit Exceeded
Last executed input: 2147483648 (10000000000000000000000000000000)
```

### 别人的算法

2147483648 输入超过了Java语言中整型的上限

原来问题就出在输入可能是无符号数字上！当输入为 2147483648 时，Java 会将这个数字判断位 -1，而右移符号 >> 在计算时会保持数字的符号位，即正数右移高位补 0，负数右移高位补 1。使用这种规则进行右移，会导致数字在右移过程中被不断补 1，这样循环永远无法停止！因此，如果输入为负数，也应该保持右移时高位补 0，位运算符 >>> 可以帮助我们解决这个问题。

```java
public int hammingWeight(int n) {

	int counter = 0;
	while (n != 0)
	{
	    if (n % 2 != 0) {
		counter++;
	    }
	    n = n >>> 1;
	}
	return counter;
}
```

1. `>>` 是带符号右移，负数高位补 1，正数补 0
2. `<<` 左移不管负数还是正数，在低位永远补 0
3. `>>>` 是不带符号右移，不论负数还是正数，高位补 0

> 引用：[LeetCode：Number of 1 Bits-整数的汉明重量-Tsybius2014](http://my.oschina.net/Tsybius2014/blog/491381)


### 别人的算法 2

- 资料：[Int 型数值存储](http://www.cnblogs.com/xinsheng/p/3419202.html)
- 资料：[原码, 反码, 补码](http://www.cnblogs.com/zhangziqiu/archive/2011/03/30/ComputerCode.html)

补码：正数为其本身，负数为取反加一

```java
// you need to treat n as an unsigned value
public int hammingWeight(int n) {
	long l = Integer.toUnsignedLong(n);
	int count = 0;
	for (; l != 0; l = l >> 1) {
	    if ((l & 1) == 1) count ++;
	}
	return count;
}
```

所以在 Java 中需要将 `int` 转换为 `unsigned int` 的时候，可以将 `int` 转换到容量更大的 `long` 中就行了，直接 `((long) x) & 0xffffffffL` 或者使用函数 `Integer.toUnsignedLong()`。

> 引用：[nekocode/leetcode-solutions-191. Number of 1 Bits](https://github.com/nekocode/leetcode-solutions/blob/master/solutions/191.%20Number%20of%201%20Bits.md)

