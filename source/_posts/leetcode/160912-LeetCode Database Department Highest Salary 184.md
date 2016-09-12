---
title: LeetCode Database Department Highest Salary 184
permalink: leetcode-database-department-highest-salary-184
date: 2016-09-12 14:00:00
comments: true
toc: true
tags: 
   - leetcode
   - mysql
description: 
---

[184. Department Highest Salary](https://leetcode.com/problems/department-highest-salary/)
&emsp;&emsp;The `Employee` table holds all employees. Every employee has an Id, a salary, and there is also a column for the department Id.
``` sql
+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
```
&emsp;&emsp;The `Department` table holds all departments of the company.
``` sql
+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
```
&emsp;&emsp;Write a SQL query to find employees who have the highest salary in each of the departments. For the above tables, Max has the highest salary in the IT department and Henry has the highest salary in the Sales department.
``` sql
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
```
<!-- more -->

### 大体意思
查询出每一个部门中收入最后的员工的信息

### 自己的解法
一开始时自己没有考虑收入最高可能有并列的情况，就直接 MAX()，加 join in 了；同时也要考虑到：所属部门不存在的情况；修改后 SQL 为

``` sql
select d.Name as Department, e.Name as Employee, e.Salary
from Employee e
    right join 
        (select max(e.Salary) as Salary, e.DepartmentId 
        from Employee e 
        group by DepartmentId ) t
    on e.Salary = t.Salary and e.DepartmentId = t.DepartmentId

    left join 
        Department d 
    on e.DepartmentId = d.Id 

having d.Name is not null 
```

### 别人的解法

基本都是连表查询的套路，但是有一段总结还是有些意思的。

1、聚合函数 max() 的效率不如嵌套子查询
2、in 与 exists 效率差不多，当时在网上查的是：
> in 和 not in 也要慎用，否则会导致全表扫描
> 很多时候用 exists 代替 in 是一个好的选择

3、将 join on 代替了 where 判断，效率提升很多，后来有个看过 MYSQL 源码的大神说：
> 在 MySQL 的 SELECT 查询当中，其核心算法就是 JOIN 查询算法。其他的查询语句都相应向 JOIN 靠拢：单表查询被当作 JOIN 的特例；子查询被尽量转换为 JOIN 查询

4、将 join 替换为了 straight_join，还是源码大神说的：
> 对于多表查询，如果可以确定表按照某一固定次序处理可以获得较好的效率，则建议加上 STRAIGHT_JOIN 子句，以减少优化器对表进行重排序优化的过程。
> 该子句一方面可以用于优化器无法给出最优排列的 SQL 语句；另一方面同样适用于优化器可以给出最优排列的 SQL 语句，因为 MySQL 算出最优排列也需要耗费较长的流程。
> 对于后一状况，可以根据 EXPLAIN 的提示选定表的顺序，并加上 STRAIGHT_JOIN 子句固定该顺序。该状况下的使用前提是几个表之间的数据量比例会一直保持在某一顺序，否则在各表数据此消彼长之后会适得其反。

对于经常调用的 SQL 语句，这一方法效果较好；同时操作的表越多，效果越好。

> Reference:
> [leetcode-184-Department Highest Salary 优化记录 - M-zyh](http://www.cnblogs.com/zhangyunhao/p/4896055.html)



