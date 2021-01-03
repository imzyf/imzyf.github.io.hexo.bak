---
title: LeetCode Database Rising Temperature 197
permalink: leetcode-database-rising-temperature-197
comments: true
date: 2016-09-11 19:00:00
toc: true
tags: 
   - leetcode
   - mysql
description:
---

[197. Rising Temperature](https://leetcode.com/problems/rising-temperature/)
&emsp;&emsp;Given a `Weather` table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.

``` sql
+---------+------------+------------------+
| Id(INT) | Date(DATE) | Temperature(INT) |
+---------+------------+------------------+
|       1 | 2015-01-01 |               10 |
|       2 | 2015-01-02 |               25 |
|       3 | 2015-01-03 |               20 |
|       4 | 2015-01-04 |               30 |
+---------+------------+------------------+
```

<!-- more -->
For example, return the following Ids for the above Weather table:

``` sql
+----+
| Id |
+----+
|  2 |
|  4 |
+----+
```

---

### 大体意思
写 SQL 查询出温度比昨天大的日期 Id

### 别人的解法

The `DATEDIFF()` function returns the time between two dates

``` sql
SELECT w1.Id FROM Weather w1, Weather w2
WHERE w1.Temperature > w2.Temperature AND (DATEDIFF(w1.Date, w2.Date) = 1 )
```

> Reference:
> [LeetCode Q197 Rising Temperature | Lei Jiang Coding](https://leijiangcoding.wordpress.com/2015/05/01/leetcode-q197-rising-temperature/)

