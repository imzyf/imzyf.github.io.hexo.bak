---
title: MySQL Illegal mix of collations
permalink: mysql-illegal-mix-of-collations
date: 2020-04-14 17:05:01
updated: 2020-08-17 21:34:58
comments: true
toc: true
tags:
  - mysql
categories:
description:
cover_img: https://images.unsplash.com/photo-1587467411873-9533e3751131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=640&q=80
feature_img:
---

```sql
Illegal mix of collations (utf8mb4_general_ci,IMPLICIT) and (utf8mb4_unicode_ci,IMPLICIT) for operation
```

<!-- more -->

`utf8mb4_unicode_ci` 和 `utf8_general_ci` 列不能混合查询

## 解决方法 1

统一字段 varchar 的编码集，我推荐使用 `utf8mb4_unicode_ci`。

## 解决方法 2

在查询 SQL 中需要转化的字段后面加 `COLLATE utf8mb4_unicode_ci`.

## 对比

准确性：

- utf8mb4_unicode_ci 是基于标准的 Unicode 来排序和比较，能够在各种语言之间精确排序。
- utf8mb4_general_ci 没有实现 Unicode 排序规则，在遇到某些特殊语言或者字符集，排序结果可能不一致。

性能：

- utf8mb4_unicode_ci 在特殊情况下，Unicode 排序规则为了能够处理特殊字符的情况，实现了略微复杂的排序算法。但是在绝大多数情况下发，不会发生此类复杂比较。相比选择哪一 collation，使用者更应该关心字符集与排序规则在 db 里需要统一。
- utf8mb4_general_ci 在比较和排序的时候更快。

## utf8mb4

mb4 是 most bytes 4 的意思，专门用来兼容四字节的 unicode。

## References

- [Illegal mix of collations | 少年阿斌](https://www.cnblogs.com/wqbin/p/11852376.html)

-- EOF --
