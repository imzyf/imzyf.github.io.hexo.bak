---
title: LeetCode Database Trips and Users 262
permalink: leetcode-database-trips-and-users-262
comments: true
date: 2016-09-14 13:45:00
toc: true
tags: 
   - leetcode
   - mysql
description:
---

[262. Trips and Users](https://leetcode.com/problems/trips-and-users/)
&emsp;&emsp;The `Trips` table holds all taxi trips. Each trip has a unique Id, while Client_Id and Driver_Id are both foreign keys to the Users_Id at the `Users` table. Status is an ENUM type of (‘completed’, ‘cancelled_by_driver’, ‘cancelled_by_client’).

``` sql
+----+-----------+-----------+---------+--------------------+----------+
| Id | Client_Id | Driver_Id | City_Id |        Status      |Request_at|
+----+-----------+-----------+---------+--------------------+----------+
| 1  |     1     |    10     |    1    |     completed      |2013-10-01|
| 2  |     2     |    11     |    1    | cancelled_by_driver|2013-10-01|
| 3  |     3     |    12     |    6    |     completed      |2013-10-01|
| 4  |     4     |    13     |    6    | cancelled_by_client|2013-10-01|
| 5  |     1     |    10     |    1    |     completed      |2013-10-02|
| 6  |     2     |    11     |    6    |     completed      |2013-10-02|
| 7  |     3     |    12     |    6    |     completed      |2013-10-02|
| 8  |     2     |    12     |    12   |     completed      |2013-10-03|
| 9  |     3     |    10     |    12   |     completed      |2013-10-03| 
| 10 |     4     |    13     |    12   | cancelled_by_driver|2013-10-03|
+----+-----------+-----------+---------+--------------------+----------+
```

&emsp;&emsp;The `Users` table holds all users. Each user has an unique Users_Id, and Role is an ENUM type of (‘client’, ‘driver’, ‘partner’).

``` sql
+----------+--------+--------+
| Users_Id | Banned |  Role  |
+----------+--------+--------+
|    1     |   No   | client |
|    2     |   Yes  | client |
|    3     |   No   | client |
|    4     |   No   | client |
|    10    |   No   | driver |
|    11    |   No   | driver |
|    12    |   No   | driver |
|    13    |   No   | driver |
+----------+--------+--------+
```
&emsp;&emsp;Write a SQL query to find the cancellation rate of requests made by unbanned clients between Oct 1, 2013 and Oct 3, 2013. For the above tables, your SQL query should return the following rows with the cancellation rate being rounded to two decimal places.

``` sql
+------------+-------------------+
|     Day    | Cancellation Rate |
+------------+-------------------+
| 2013-10-01 |       0.33        |
| 2013-10-02 |       0.00        |
| 2013-10-03 |       0.50        |
+------------+-------------------+
```
<!-- more -->

### 大体意思
写一个 SQL 语句，查询非禁止客户（Users表中Banned列为No的客户）在 2013-10-1 至 2013-10-3 间的单据取消率，结果为四舍五入后的两位有效数字。

### 别人的解法

``` sql
SELECT Request_at DAY,
       ROUND(SUM(IF(Status = 'completed', 0, 1)) / COUNT(*), 2) 'Cancellation Rate'
FROM   Trips t
	LEFT JOIN Users t1 ON t.Client_Id = t1.Users_Id
WHERE  t1.Banned = 'No' AND Request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP  BY t.Re	quest_at;
```

这道题主要是统计计算

笔记：
1、函数：ROUND(column_name,decimals)
`column_name`	必需。要舍入的字段
`decimals`	必需。规定要返回的小数位数

2、`SUM(IF(Status = 'completed', 0, 1))`
统计 SUM 这里也好巧妙

3、`having` 与 `where` 的区别
having 字句可以让我们筛选成组后的各种数据，where 字句在聚合前先筛选记录，也就是说作用在 group by 和 having 字句前。而 having 子句在聚合后对组记录进行筛选。
``` sql
SELECT region, SUM(population), SUM(area)
FROM bbc
GROUP BY region
HAVING SUM(area) > 1000000
```
在这里，我们不能用 where 来筛选超过 1000000 的地区，因为表中不存在这样一条记录。相反，having 子句可以让我们筛选成组后的各组数据


> Reference:
> [LeetCode：Trips and Users - 出租车接单取消率 - Tsybius2014](https://my.oschina.net/Tsybius2014/blog/496047)
> [mysql中的where和having子句的区别 - Hukin](http://www.blogjava.net/Johnny-Ajun/archive/2011/08/28/357445.html)

