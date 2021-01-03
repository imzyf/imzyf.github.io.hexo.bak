---
title: LeetCode Excel Sheet Column Number 171
permalink: leetcode-excel-sheet-column-number-171
comments: true
date: 2016-08-22 13:00:00
toc: true
tags:
   - leetcode
description:
---

[171. Excel Sheet Column Number](https://leetcode.com/problems/excel-sheet-column-number/)
&emsp;&emsp;Given a column title as appear in an Excel sheet, return its corresponding column number.
<!-- more -->
For example:
``` java
    A -> 1
    B -> 2
    C -> 3
    ...
    Z -> 26
    AA -> 27
    AB -> 28 
```

### 自己的思路

很像是“二十六进制”转十进制

``` java
public int titleToNumber(String s) {
	int col = 0;
	char[] chars = s.toCharArray();
	int i = 0;
	while (i < chars.length) {
		int charInt = chars[chars.length - 1 - i] - 64;
		col += Math.pow(26, i) * charInt;
		i++;
	}
	return col;
}
```

在算法问题中常常用到：
- `1` 的 ascii 为33，十六进制为21H
- `A` 的 ascii 为65，十六进制为41H
- `a` 的 ascii 为97，十六进制为61H

上面有个写的不好的地方就是 64，好像的很莫名的一个数字，其实时在将 A 折算为 1



