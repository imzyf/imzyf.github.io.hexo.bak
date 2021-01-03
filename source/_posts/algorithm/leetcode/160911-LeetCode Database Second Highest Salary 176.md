---
title: LeetCode Database Second Highest Salary 176
permalink: leetcode-database-second-highest-salary-176
comments: true
date: 2016-09-11 19:45:00
toc: true
tags: 
   - leetcode
   - mysql
description:

---

[176. Second Highest Salary](https://leetcode.com/problems/second-highest-salary/)
&emsp;&emsp;Write a SQL query to get the second highest salary from the `Employee` table.

``` sql
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
```

For example, given the above Employee table, the second highest salary is `200`. If there is no second highest salary, then the query should return `null`.

<!-- more -->

### 大体意思
写 SQL 查询出第二高薪水的 Id。如何没有第二高，则返回 `null`

### 自己的解法

```
SELECT
    Salary
FROM
    Employee
ORDER BY Salary DESC
LIMIT 1,1
```

但是在没有第二高的时候将没有返回值，不符合题意；看了别人的，发现自己也少考虑 `DISTINCT`

### 别人的解法
多加一层 SELECT 并添加一个 IF 条件判断。如果结果有 0 行则返回 NULL，有 1 行返回正常结果。由于可以预期上一步结果只有一个，所以这里可以用 COUNT 而不用 GROUP BY。

构造测试数据：

``` sql
CREATE TABLE IF NOT EXISTS Employee (
    Id INT,
    Salary INT
);
DELETE FROM Employee;
INSERT INTO Employee VALUES
(1, 100),
(2, 200),
(3, 100),
(4, 300);
```

预期结果：

``` sql
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
```

解法一：

``` sql
SELECT 
    IF(COUNT(Salary) >= 1, Salary, NULL) AS SecondHighestSalary
FROM
    (SELECT DISTINCT
        Salary
    FROM
        Employee
    ORDER BY Salary DESC
    LIMIT 1 , 1) tmp
```

解法二：
正常 Ranking 类问题解法，使用自定义变量计算排名。接着和上面一种解法类似需要对结果进行处理，没有第 2 名的返回 NULL：

``` sql
SELECT 
    IF(COUNT(Salary) >= 1, Salary, NULL) AS SecondHighestSalary
FROM
    (SELECT DISTINCT
        Salary
    FROM
        (SELECT 
	        Id,
            Salary,
            @rank:=IF(@prevVal > Salary, @rank:=@rank + 1, @rank) AS Rank,
            @prevVal:=Salary
	    FROM
	        Employee, (SELECT @prevVal:=NULL) x, (SELECT @rank:=1) y
	    ORDER BY Salary DESC) tmp
    WHERE
        tmp.Rank = 2) tmp2
```

解法三：
上面两种解法都是可以扩展到任意排名的，如果想偏一点可以得到其他解法。排名第 2 可以看做是除了 MAX 之外的 MAX，可以得到这两种类似的解法。由于 MAX 函数可以返回 NULL 结果，就不用在进一步加工结果。

``` sql
SELECT 
    MAX(Salary)
FROM
    Employee
WHERE
    Salary < (SELECT 
            MAX(Salary)
        FROM
            Employee)
```


``` sql
SELECT 
    MAX(Salary)
FROM
    Employee
WHERE
    Salary NOT IN (SELECT 
            MAX(Salary)
        FROM
            Employee)
```

> Reference:
> [Leetcode Database: #176 Second Highest Salary | tsuinteru](http://tsuinte.ru/2015/04/05/leetcode-database-176-second-highest-salary/)

