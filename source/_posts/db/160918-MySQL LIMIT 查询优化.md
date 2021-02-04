---
title: MySQL LIMIT 查询优化
permalink: mysql-limit-query-optimization
date: 2016-09-18 14:00:00
updated: 2019-05-22 17:06:35
comments: true
toc: true
tags:
  - mysql
categories:
description:
cover_img:
feature_img:
---

最近常在 SQL 中使用到 `LIMIT ? ?`，在执行 `LIMIT 0, 1000` 与 `LIMIT 100000, 1000` 时，查询速度明显有很大的区别，而且随着 LIMIT 的偏移量的增加，查询速度越来越慢。是否有办法对 SQL 中 LIMIT 查询进行优化呢？

<!-- more -->

## LIMIT 速度慢的原因

LIMIT 100000, 1000 的意思扫描满足条件的 101000 行，扔掉前面的 100000 行，返回最后的 1000 行，问题就在这里。

## LIMIT 优化思路

1、尽可能从索引中直接获取数据，避免或减少直接扫描行数据的频率
2、尽可能减少扫描的记录数，也就是先确定起始的范围，再往后取 N 条记录即可

## LIMIT 优化示例

### 原始 SQL

```sql
-- 含条件
SELECT * FROM `t1` WHERE ftype=1 ORDER BY id DESC LIMIT 100, 10;
-- 不含 WHERE
SELECT * FROM `t1` ORDER BY id DESC LIMIT 100, 10;
```

### 子查询优化 SQL

```sql
-- 采用子查询的方式优化，在子查询里先从索引获取到最大 id，然后倒序排，再取 10 行结果集
-- 注意这里采用了 2 次倒序排，因此在取 LIMIT 的 start 值时，比原来的值加了 10，即 935510，否则结果将和原来的不一致
SELECT * FROM
  (SELECT * FROM `t1` WHERE id >
    ( SELECT id FROM `t1` WHERE ftype=1 ORDER BY id DESC LIMIT 935510, 1)
  LIMIT 10) T
ORDER BY id DESC;
```

### INNER 优化 SQL

```sql
-- 采用 INNER JOIN 优化，JOIN 子句里也优先从索引获取 ID 列表，然后直接关联查询获得最终结果，这里不需要加 10
SELECT * FROM `t1`
  INNER JOIN ( SELECT id FROM `t1`
    WHERE ftype=1 ORDER BY id DESC LIMIT 935500,10) t2
  USING (id);
```

1、要学着使用 `EXPLAIN` 对 SQL 进行优化调整
2、推荐使用 INNER 优化 SQL
3、发现了一个 ubuntu 中监控 MySQL 的 `mytop` 命令，刚刚安装还没细研究

```bash
sudo apt-get install mytop
```

4、`USING (id)` 如果两个表的字段名都一样，那么可以用 using(字段名) 来协商条件，效果跟 `on a.id = b.id` 一样

## References

- [MySQL 优化案例系列 — 分页优化 | iMySQL](http://imysql.com/2014/07/26/mysql-optimization-case-paging-optimize.shtml)
- [MYSQL 分页 limit 速度太慢优化方法 | Fienda blog](http://www.fienda.com/archives/110)

-- EOF --
