---
title: LeetCode Excel Sheet Column Title 168
permalink: leetcode-excel-sheet-column-title-168
comments: true
date: 2016-08-22 13:40:00
toc: true
tags:
   - leetcode
description:
---

[168. Excel Sheet Column Title](https://leetcode.com/problems/excel-sheet-column-title/)
&emsp;&emsp;Given a positive integer, return its corresponding column title as appear in an Excel sheet.
<!-- more -->
For example:
``` java
    1 -> A
    2 -> B
    3 -> C
    ...
    26 -> Z
    27 -> AA
    28 -> AB 
```

### 自己的思路
十进制转“二十六进制”

``` java
public String convertToTitle(int n) {
	String str = "";
	do {
		int chrInt = n % 26;
		char chr;
		if (chrInt == 0) {
			chr = 'Z';
			n -= 26;
		} else {
			chr = (char) (chrInt - 1 + 'A');
		}
		str = chr + str;
		n = n / 26;
	} while (n != 0);
	return str;
}
```

### 别人的思路

``` java
public String convertToTitle(int n) {
    if(n <= 0){
        throw new IllegalArgumentException("Input is not valid!");
    }
 
    StringBuilder sb = new StringBuilder();
 
    while(n > 0){
        n--;
        char ch = (char) (n % 26 + 'A');
        n /= 26;
        sb.append(ch);
    }
 
    sb.reverse();
    return sb.toString();
}
```
思路是一样的，但是代码更简洁，使用了`StringBuilder` 和 `reverse()`，提前减1也避免了特殊处理'Z'


在算法问题中常常用到：
- `1` 的 ascii 为33，十六进制为21H
- `A` 的 ascii 为65，十六进制为41H
- `a` 的 ascii 为97，十六进制为61H

