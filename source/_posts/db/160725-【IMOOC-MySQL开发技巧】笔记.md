---
title: 【IMOOC-MySQL开发技巧】笔记
permalink: imooc-mysql-development-skills-notes
date: 2016-07-25 10:00:00
updated:
comments: true
toc: true
tags:
  - mysql
categories:
description:
cover_img:
feature_img:
---

主要涉及：JOIN 、JOIN 更新、GROUP BY HAVING 数据查重/去重。

<!-- more -->

## INNER

INNER JOIN、LEFT JOIN、RIGHT JOIN、FULL JOIN(MySQL 不支持)、CROSS JOIN

这是在网上找到的非常好的一篇博文，图解 JOIN 语句：

> [CODING HORROR-A Visual Explanation of SQL Joins](https://blog.codinghorror.com/a-visual-explanation-of-sql-joins/)

下图可以很清楚的明白，JOIN 的数据选取范围：

![160725-imooc-mysql-development-skills-notes-001](https://user-images.githubusercontent.com/9289792/80199172-9d701f80-8653-11ea-8d20-498f54e41708.png)

![160725-imooc-mysql-development-skills-notes-002](https://user-images.githubusercontent.com/9289792/80199188-9fd27980-8653-11ea-9386-e76dca7b4d0c.jpeg)

## 更新使用过滤条件中包括本身的表

更新 `t1` `t2` 表中 `col_a` 重复的字段：

```sql
UPDATE t1
SET col_a = 'hi'
WHERE t1.col_a IN (
  SELECT b.col_a
  FROM t1 a INNER JOIN t2 b on
  a.col_a = b.col_a
)
;
ERROR:1093
```

可转换为：

```sql
UPDATE t1 aa JOIN(
  SELECT b.col_a
  FROM t1 a INNER JOIN t2 b on
  a.col_a = b.col_a
)bb on aa.col_a= bb.col_a
SET col_a = 'hi'
;
```

## 查询重复数据、删除重复数据

利用 `GROUP BY` 和 `HAVING` 查询重复数据：

```sql
SELECT col_a, COUNT(*)
FROM t1
GROUP BY col_a HAVING COUNT(*) > 1
;
```

删除重复数据，对于相同数据保留 ID 最大的：

```sql
DELETE a
FROM t1 a JOIN (
  SELECT col_a,COUNT(*),MAX(id) AS id
  FROM t1
  GROUP BY col_a HAVING COUNT(*) > 1
)b ON a.col_a = b.col_a
WHERE a.id < b.id
;
```

-- EOF --
