---
title: Yii2 Code Snippet
permalink: yii2-code-snippet
date: 2021-01-19 12:08:13
updated: 2021-01-27 17:17:54
tags:
  - php
  - yii2
  - code-snippet
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

## gii CLI

```bash
php yii help gii/mode

php yii gii/model --generateLabelsFromComments=1 --overwrite=1 --standardizeCapitals=1 --ns='app\models\gii' --tableName="*"

# 多数据库
php yii gii/model --generateLabelsFromComments=1 --overwrite=1 --standardizeCapitals=1 --db="hub_db" --ns='app\models\hub\gii' --tableName="*"
```

## DB where

- 字符串格式，例如：`'status=1'`
- 哈希格式，例如： `['status' => 1, 'type' => 2]`
- 操作符格式，例如：`['like', 'name', 'test']`
- 对象格式，例如：`new LikeCondition('name', 'LIKE', 'test')`

### 简单条件

```php
// SQL: (type = 1) AND (status = 2).
$cond = ['type' => 1, 'status' => 2]

// SQL: (id IN (1, 2, 3)) AND (status = 2)
$cond = ['id' => [1, 2, 3], 'status' => 2]

// SQL: status IS NULL
$cond = ['status' => null]
```

### AND OR

```php
// SQL: `id=1 AND id=2`
$cond = ['and', 'id=1', 'id=2']

// SQL: `type=1 AND (id=1 OR id=2)`
$cond = ['and', 'type=1', ['or', 'id=1', 'id=2']]

// SQL: `type=1 AND (id=1 OR id=2)`
// 此写法 '=' 可以换成其他操作符，例：in like != >= 等
$cond = [
    'and',
    ['=', 'type', 1],
    [
        'or',
        ['=', 'id', '1'],
        ['=', 'id', '2'],
    ]
]
```

### NOT

```php
// SQL: `NOT (attribute IS NULL)`
$cond = ['not', ['attribute' => null]]
```

### BETWEEN

```php
// not between 用法相同
// SQL: `id BETWEEN 1 AND 10`
$cond = ['between', 'id', 1, 10]
```

### IN

```php
// not in 用法相同
// SQL: `id IN (1, 2, 3)`
$cond = ['between', 'id', 1, 10]
$cond = ['id' => [1, 2, 3]]

// IN 条件也适用于多字段
// SQL: (`id`, `name`) IN ((1, 'foo'), (2, 'bar'))
$cond = ['in', ['id', 'name'], [['id' => 1, 'name' => 'foo'], ['id' => 2, 'name' => 'bar']]]

// 也适用于内嵌 SQL 语句
$cond = ['in', 'user_id', (new Query())->select('id')->from('users')->where(['active' => 1])]
```

### LIKE

```php
// SQL: `name LIKE '%tester%'`
$cond = ['like', 'name', 'tester']

// SQL: `name LIKE '%test%' AND name LIKE '%sample%'`
$cond = ['like', 'name', ['test', 'sample']]

// SQL: `name LIKE '%tester'`
$cond = ['like', 'name', '%tester', false]
```

### EXIST

```php
// not exists用法类似
// SQL: EXISTS (SELECT "id" FROM "users" WHERE "active"=1)
$cond = ['exists', (new Query())->select('id')->from('users')->where(['active' => 1])]
```

## References

- [查询构建器 | yiiframework](https://www.yiiframework.com/doc/guide/2.0/zh-cn/db-query-builder)
- [YII where 条件 | csdn](https://blog.csdn.net/u013697959/article/details/79687746)

-- EOF --
