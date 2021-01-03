---
title: LeetCode  Happy Number 202
permalink: leetcode-happy-number-202
comments: true
date: 2016-08-29 14:00:00
toc: true
tags:
   - leetcode
description:
---

[202. Happy Number](https://leetcode.com/problems/happy-number/)
&emsp;&emsp;Write an algorithm to determine if a number is "happy".
&emsp;&emsp;A happy number is a number defined by the following process: Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1. Those numbers for which this process ends in 1 are happy numbers.
<!-- more -->
&emsp;&emsp;**Example**: 19 is a happy number
```
1^2 + 9^2 = 82
8^2 + 2^2 = 68
6^2 + 8^2 = 100
1^2 + 0^2 + 0^2 = 1
```

---

### 大体意思
题目说的是取任意一个正整数，不断各个数位上数字的平方和，若最终收敛为1，则该数字为`happy number`，否则程序可能从某个数开始陷入循环。

### 自己的思路
关键：通过 `/` 和 `%` 取 int 各个位的数字；用 `set` 判重复

``` java
public static boolean isHappy(int n) {
    Set<Integer> result = new HashSet<>();
    int newN = 0;
    do {
        do {
          int end = n % 10;
          n = n / 10;
          newN += Math.pow(end, 2);
        } while (n != 0);

        n = newN;
        newN = 0;
        if (result.contains(n)) {
          return false;
        } else {
          if (n == 1) {
            return true;
          } else {
            result.add(n);
          }
        }
    } while (true);
}
```

套路：取各个位数字
``` java
do {
  int end = n % 10;
  n = n / 10;
} while (n != 0);
```
