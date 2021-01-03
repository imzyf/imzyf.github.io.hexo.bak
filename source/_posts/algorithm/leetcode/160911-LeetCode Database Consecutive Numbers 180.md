---
title: LeetCode Database Consecutive Numbers 180
permalink: leetcode-database-consecutive-numbers-180
comments: true
date: 2016-09-11 20:45:00
toc: true
tags: 
   - leetcode
   - mysql
description:
---

[180. Consecutive Numbers](https://leetcode.com/problems/consecutive-numbers/)
&emsp;&emsp;Write a SQL query to find all numbers that appear at least three times consecutively.
``` sql
+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+
```
For example, given the above `Logs` table, `1` is the only number that appears consecutively for at least three times.
<!-- more -->

### 大体意思
写 SQL 查询出连续出现至少 3 次的 Num

### 自己的解法

``` sql
SELECT DISTINCT L1.Num AS ConsecutiveNums
FROM Logs L1
	JOIN Logs L2 ON L1.Id + 1 = L2.Id
	JOIN Logs L3 ON L1.Id + 2 = L3.Id
WHERE L1.Num = L2.Num AND L1.Num = L3.Num
```

 很传统连表查询，但是有坑的地方，就是依靠的时 Id，所以局限是 Id 要连贯

### 别人的解法

首先，增加一个 rank 字段，记录序号，初始值为 1，当后一个值与前一个值相等时，序号加 1。之后，把所有 rank 值大于等于 3 的都检索出来，再去重即可。

``` sql
SELECT DISTINCT(Num) AS ConsecutiveNums FROM
(SELECT Id,Num,
@Rank:=IF(@prevNum != Num,1,@Rank+1) AS Rank,
@prevNum:=Num 
FROM Logs) t, 
(SELECT @Rank:=0,@prevNum:=NULL) r 
WHERE t.Rank >= 3; 
```

### 自己的理解
```
(SELECT @Rank:=0,@prevNum:=NULL) r
```
是个巧妙的地方，对变量进行了初始化

> Reference:
> [【leetcode Database】180. Consecutive Numbers - Kevin_zhai的博客](http://blog.csdn.net/Kevin_zhai/article/details/52152289)

