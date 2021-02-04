---
title: MySQL JSON 数据类型
permalink: mysql-json-data-type
date: 2020-08-14 19:39:55
updated:
comments: true
toc: true
tags:
  - redis
categories:
description:
cover_img:
feature_img:
---

[The JSON Data Type | mysql](https://dev.mysql.com/doc/refman/5.7/en/json.html)

> As of MySQL 5.7.8, MySQL supports a native JSON data type

[JSON Function Reference | mysql](https://dev.mysql.com/doc/refman/5.7/en/json-function-reference.html)

A JSON column cannot have a non-NULL default value.

## 索引

设置虚拟列 -> 虚拟列建立索引

在 MySQL 5.7 中，支持两种 Generated Column，即 Virtual Generated Column 和 Stored Generated Column，前者只将 Generated Column 保存在数据字典中（表的元数据），并不会将这一列数据持久化到磁盘上；后者会将 Generated Column 持久化到磁盘上，而不是每次读取的时候计算所得。很明显，后者存放了可以通过已有数据计算而得的数据，需要更多的磁盘空间，与 Virtual Column 相比并没有优势，因此，MySQL 5.7 中，不指定 Generated Column 的类型，默认是 Virtual Column。

如果需要 Stored Generated Golumn 的话，可能在 Virtual Generated Column 上建立索引更加合适，一般情况下，都使用 Virtual Generated Column，这也是 MySQL 默认的方式。

```json
{
  "id": 1,
  "name": "Sally",
  "games_played": {
    "Battlefield": {
      "weapon": "sniper rifle",
      "rank": "Sergeant V",
      "level": 20
    }
  }
}
```

```sql
CREATE TABLE `players` (
  `id` INT UNSIGNED NOT NULL,
  `player_and_games` JSON NOT NULL,
  `names_virtual` VARCHAR(20) GENERATED ALWAYS AS (`player_and_games` ->> '$.name') NOT NULL,
  PRIMARY KEY (`id`)
);
```

## 在 Yii2 中的使用

```php
$query = static::find()
    ->andWhere(['=', new Expression("`json_value` -> '$.source'"), new JsonExpression($array_param)]);
```

## References

- [MySQL 5.7 新特性 JSON 的创建，插入，查询，更新](https://www.lnmp.cn/mysql-57-new-features-json.html)
- [MySQL · 最佳实践 · 如何索引 JSON 字段](http://mysql.taobao.org/monthly/2017/12/09/)
- [MySQL 常用 Json 函数 | cnblogs](https://www.cnblogs.com/waterystone/p/5626098.html)

-- EOF --
