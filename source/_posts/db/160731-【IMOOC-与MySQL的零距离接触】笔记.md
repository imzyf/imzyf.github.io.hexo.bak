---
title: 【IMOOC-与MySQL的零距离接触】笔记
permalink: imooc-meet-mysql-notes
comments: true
date: 2016-07-31 10:00:00
toc: true
tags:
   - mysql
description:
---

涵盖全部 MySQL 数据库的基础，MySQL 数据库的基础知识、数据表的常用操作及各种约束的使用，以及综合的运用各种命令实现记录进行 CURD 等操作。

- MySQL 安装与配置
- 数据类型
- 流程控制与运算符
- DDL、DCL、DQL、DML
- 常用函数
- 表类型（存储引擎）
- 图形化工具

<!-- more -->

## 修改 MySQL 提示符

MySQL 客户端的默认提示符是 `mysql>`，基本上没什么实际作用。其实可以修改这个提示符，让它显示一些有用的信息，例如当前所在的数据库等。修改方法有四种，其中前两种只对当前连接有效，后两种则对所有连接有效。

### 连接客户端时通过参数指定

```bash
mysql --prompt="(\u@\h) [\d]> "
```

这样提示符就会变成 `(user@host) [database]>`。其中常用的字符参数有：

- `\D` 完整的日期
- `\d` 当前数据库
- `\h` 服务器名称
- `\u` 当前用户

连接上客户端后，通过 `prompt` 命令修改

```sql
prompt (\u@\h) [\d]>
```

在 MySQL 的配置文件中配置。

```sql
prompt=(\\u@\\h) [\\d]>\\_
```

通过环境变量配置。

```sql
export MYSQL_PS1="(\u@\h) [\d]> "
```

> 参考：http://renial.iteye.com/blog/773675

## MySQL 语法规范

- 关键字和函数名称全部 **大写**
- 数据库名称，表名称，字段名称全部 **小写**
- SQL 语句必须以 **分号结尾**

## 数据库操作

### 数据库创建：CREATE

- 语法：CREATE {DATABASE SCHEMA} [IF NOT EXISTS] db_name [DEFAULT] CHARACTER SET [=] charset_name
- DATABASE 和 SCHEMA 是相同的，任选其一
- IF NOT EXISTS:如果创建的数据库存在，则不只报出 warning，不写会报错
- CHRARCTER SET utf8:为表设置编码方式，如果不设置则用 mysql 默认的编码方式

### 查看数据库列表：SHOW

- SHOW { DATABASE SCHEMAS } [LIKE 'pattern' WHERE expr]
- SHOW CREATE DATABASE xx：显示 xx 数据库信息

### 数据库的修改：ALTER

- 修改数据库编码方式：ALTER { DATABASE SCHEMAS } [db_name][default] CHARACTER SET [=] charset_name

### 删除数据库：DROP

- 删除数据库：DROP { DATABASE SCHEMAS } [IF EXISTS] db_name;

```sql
--修改mysql操作符为当前日期
mysql -uroot -proot prompt \D
--展示所有数据库
show databases;
--创建数据库
create database if not exists t1 character set gbk;
--展示数据库t1的创建命令和编码形式
show create database t1;
--修改数据库编码格式
alter database t2 character set = utf8;
--删除数据库
drop database if exists t1;
--展示警告信息
show warnings;
```

## 四、数据类型

![数据类型 int](https://cdn-qn.yifans.com/160731-imooc-mysql-tutorials-notes-int.png)

![数据类型 float](https://cdn-qn.yifans.com/160731-imooc-mysql-tutorials-notes-float.png)

![数据类型 char](https://cdn-qn.yifans.com/160731-imooc-mysql-tutorials-notes-char.png)

- char 型字符串有 0-255 之间的字节，通常被称作定长类型。所存字节不满 char 型所给它的字节，剩下的以空格补齐，仍会存储满你所给它的字节。
- varchar 型的字符串是变长类型，存多少字节它就存储多少字节，不会在后面补上空格。字节长度在 0-65535 之间。
- 1 个字节等于 8 个 bit，L+ 几个字节后面的几个字节指的是他的最大存储范围。8 个 bit 等于就是 8 个 1，相当于 255，就是 2 的 8 次方。16 个 1 就相当于 2 的 16 次方。3 个字节四个字节依次类推。
- ENUM 枚举值 就是给他几个选项，它从这几个选项中做选择，最多有 65535 个值。
- SET 我们称之为集合，集合最多有 64 个成员，它在这些集合成员中做任意的排列组合。

![imooc-mysql-tutorials-notes-time](https://cdn-qn.yifans.com/160731-imooc-mysql-tutorials-notes-time.png?v=1)

- YEAR：2 位或者 4 位，1970 到 2069 年，允许 70 到 69
- TIME：-8385959 到 8385959
- DATE：1000.01.01 到 9999.12.31
- DATETIME：1000.01.01 00:00:00 到 9999.12.31 23:59:59
- TIMESTAMP：1970.01.01 00 点起 到 2037 年之间的一个值

## 五、数据表操作

- 数据表（或表）是数据库最重要的组成部分之一，是其他对象的基础
- 表是一个二维表，行称为 `记录`，列称为 `字段`

### 创建数据表据表

1、打开数据库：`USE db_name;`
2、查看当前数据库：`SELECT DATABASE();`
3、创建数据表：

```sql
CREATE TABLE [IF NOT EXISTS] table_name(
column_name data_type,
...
column_name data_type
)
```

```sql
CREATE TABLE tb1(
username VARCHAR(20),
userage TINYINT UNSIGNED,
salary FLOAT(8,2) UNSIGNED,
);
```

### 查看数据表

```sql
SHOW TABLES [FROM db_name] [LIKE 'pattern' WHERE expr];
```

查看当前选择的数据库的所有表

```sql
SHOW TABLES;
```

查看 MYSQL 数据库中的所有表，当前选择数据库位置不变

```sql
SHOW TABLES FROM MYSQL;
```

查看当前选择的数据库

```sql
SELECT DATABASE();
```

查看数据表结构

```
SHOW COLUMNS FROM table_name;
```

### 插入与查找

插入记录

```
INSERT [INTO] tb_name [(col_name,col_name,...)] VALUES (va1,...)
```

查找记录

```
SELECT expr,.. FROM tb_name
```

### 空值与非空

NULL，字段值可以为空
NOT NULL，字段值禁止为空

```
CREATE TABLE tb2(
username VARCHAR(20) NOT NULL;
age TINYINT UNSIGNE NULL;
);
```

### 自动编号

自动编号 `AUTO_INCREMENT`
自动编号，且必须与主键配合使用

自动编号 AUTO_INCREMENT 作用
1、自动编号：保证记录的唯一性
2、类型必须为整型（可以是 FLOAT(5,0)等，小数点后必须为 0），必须和主键 PRIMARY KEY 组合使用
3、默认情况下，起始值为 1，每次的增量为 1

```
CREATE TABLE tb3(
id SMALLINT UNSIGNED AUTO_INCREMENT,
username VARCHAR(30) NOT NULL);
-- 报错，自动增量字段必须设置成主键
```

### 主键约束

`PRIMARY KEY`，也可以写成`KEY`
1、每张数据表只能存在一个主键
2、主键保证记录的唯一性
3、主键自动为`NOT NULL`，即必须要为主键赋值。但如果记录中添加了`AUTO_INCREMENT`，那么不需要手动赋值
4、`auto_increment`必须和主键`primary key`一起使用，但主键`primary key`不一定要和`auto_increment`一块使用

```
CREATE TABLE tb3(
id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(30) NOT NULL);
```

### 唯一约束

`PRIMARE KEY`
主键约束 一张表中只能有一个

`UNIQUE KEY`
1、唯一约束
2、唯一约束可以保证记录的唯一性
3、唯一约束的字段可以为空值
4、每张数据表可以存在多个唯一约束

```
CREATE TABLE tb3(
id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(30) NOT NULL UNIQUE KEY,
age tinyint UNSIGNED
);
```

- 在创建索引时也是有区别的

### 默认约束

`DEFAULT` 当插入记录时，如果没有明确为字段赋值，则自动赋予默认值。

```
CREATE TABLE tb6(
id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(20) NOT NULL UNIQUE KEY,
sex ENUM('1','2','3') DEFAULT '3'
);
```

其中对性别字段默认选择`3`

## 六、约束以及修改数据表

- FOREIGN KEY：保持数据一致性，完整性；实现一对一或一对多关系。
- 要求：父表和子表必须使用相同的存储引擎,而且禁止使用临时表；数据表的存储引擎只能为 InnoDB；外键列和参照列必须具有类似的数据类型。其中数字的长度或是否有符号位必须相同；而字符的长度则可以不同；外键列和参照列必须创建索引。如果外键列不存在索引的话，MySQL 将自动创建索引。
- 在 MY.ini 文件中编辑默认的存储引擎：default-storage-engine=INNODB；
- 显示创建表的语句：SHOW CREATE TABLE table_name；
- 查看表是否有索引：SHOW INDEXS FROM table_name；
- 以网格查看表是否有索引：SHOW INDEXS FROM table_name\G；

```
CREATE TABLE table_name1(
id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL
)
```

```
CREATE TABLE table_name2(
id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(20) NOT NULL,
pid SMALLINT UNSIGNED,
FOREIGN KEY (pid) REFERENCES table_name1(id) /* 外键 pid 参照 table_name1中的 id 字段 */
)
```
