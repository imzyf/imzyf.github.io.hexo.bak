---
title: Ubuntu 下安装配置 Sphinx 及在 PHP 中使用
permalink: install-and-configre-sphinx-and-using-by-php-in-ubuntu
date: 2017-05-24 16:00:00
updated:
tags:
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

2020-08-10 更新：此文章内容不确定是否已失效。

## what is Sphinx

Sphinx 是一个可全文搜索的开源搜索引擎。最大的特点是可以有效地执行大数据的搜索。要索引的数据可以来自完全不同的源：SQL 数据库，纯文本文件，HTML 文件，邮箱等。

## environment

- Ubuntu 14.04

## install

```bash
sudo apt-get install sphinxsearch -y
# sudo aptitude install sphinx3 sphinx3-doc sphinxsearch sphinx-common -y
```

## configuring Sphinx

```bash
sudo vim /etc/sphinxsearch/sphinx.conf
```

Sphinx 配置包含 3 个必须运行的主要块。它们是 `index` `searchd` `source`

<!-- more -->

### source

The `source` block contains the type of source, username and password to the MySQL server. The first column of the SQL query should be a unique id. The SQL query will run on every index and dump the data to Sphinx index file. Below are descriptions of each field and the source block itself.

- `sql_query`: This is the query thats dumps data to index.

```bash
source src1
{
  type          = mysql
  sql_host      = localhost
  sql_user      = root
  sql_pass      = password
  sql_db        = test
  sql_port      = 3306 # optional, default is 3306

  sql_query     = \
  SELECT id, group_id, UNIX_TIMESTAMP(date_added) AS date_added, title, content \
  FROM documents

  sql_attr_uint     = group_id
  sql_attr_timestamp    = date_added

  sql_query_info        = SELECT * FROM documents WHERE id=$id
}
```

### index

The `index` component contains the source and the path to store the data.

- `source`: Name of the source block. In our example, this is src1.
- `path`: This path to save the index.
- `charset_type`: This is the charset of the index.

```bash
index test1
{
  source            = src1
  path          = /var/lib/sphinxsearch/data/test1
  docinfo           = extern
  charset_type      = utf-8
}
```

### searchd

The searchd component contains the port and other variables to run the Sphinx daemon.

- `listen`: This is the port which sphinx daemon will run. In our example, this is 9312.
- `query_log`: This path to save the query log.
- `pid_file`: This is path to PID file of Sphinx daemon.
- `max_matches`: Maximum number matches to return per search term.
- `seamless_rotate`: Prevents searchd stalls while rotating indexes with huge amounts of data to precache.
- `preopen_indexes`: Whether to forcibly preopen all indexes on startup.
- `unlink_old`: Whether to unlink old index copies on successful rotation.

```bash
searchd
{
  listen            = 9312   # Port to listen on
  log           = /var/log/sphinxsearch/searchd.log
  query_log     = /var/log/sphinxsearch/query.log
  read_timeout      = 5
  max_children      = 30
  pid_file      = /var/run/sphinxsearch/searchd.pid
  max_matches       = 1000
  seamless_rotate       = 1
  preopen_indexes       = 1
  unlink_old        = 1
  binlog_path       = /var/lib/sphinxsearch/data
}
```

## adding data to the index

```bash
sudo indexer -c /etc/sphinxsearch/sphinx.conf test1
# sudo indexer --all
```

为了使索引保持最新，创建 cronjob

```bash
crontab -e
```

```bash
@hourly /usr/bin/indexer --rotate --config /etc/sphinxsearch/sphinx.conf --all
```

## starting Sphinx

```bash
sudo searchd -c /etc/sphinxsearch/sphinx.conf
```

### other way

默认情况下，Sphinx 守护程序已关闭。要启用 Sphinx，首先打开 `/etc/default/sphinxsearch`

```bash
sudo vim /etc/default/sphinxsearch
```

Find the line `START=no` and set it to yes.

```bash
START=yes
```

Finally, start the Sphinx daemon.

```bash
sudo service sphinxsearch start
```

但是我遇到：

```bash
Job for sphinxsearch.service failed because the control process exited with error code. See "systemctl status sphinxsearch.service" and "journalctl -xe" for details
```

### stop

```bash
sudo searchd --stop
```

## testing search

```bash
sudo search -c /etc/sphinxsearch/sphinx.conf google
```

## using Sphinx by PHP

### install PHP extension

> 个人不推荐，下面有更新内容

安装 PHP Sphinx 依赖库

```bash
sudo apt-get install libsphinxclient-dev libsphinxclient-0.0.1 -y
```

安装 PHP Sphinx 扩展

```bash
sudo pecl install sphinx
```

在配置文件 `php.ini` 中添加 Sphinx 的扩展

```bash
sudo vim /etc/php5/fpm/php.ini
```

```bash
extension=sphinx.so
```

重启 php5-fpm

```bash
sudo /etc/init.d/php5-fpm restart
```

### call in PHP

> 个人不推荐，下面有更新内容

```php
public function testSphinx()
{
  $s = new \SphinxClient;
  $s->setServer("localhost", 9312);
  $s->SetArrayResult (true);
  $s->setMatchMode(SPH_MATCH_ANY);
  $s->setMaxQueryTime(3);
  $result = $s->query("test");
  $result = $result['matches'];
  $result = array_column($result,'id');
  dump($result);
}
```

### using nilportugues/sphinx-search

**2017-07-19 更新：**

我在 Ubuntu 16.04 环境下，发现 `libsphinxclient-dev` `libsphinxclient-0.0.1` 无法正常安装，所以查找其他方法。

[Installing Sphinx PHP API on Ubuntu 16.04 | Sphinx](http://sphinxsearch.com/forum/view.html?id=15228) 中提到了 `sphinxapi.php`，联想到最近使用的 Composer，找到了 [nilportugues/sphinx-search - Packagist](https://packagist.org/packages/nilportugues/sphinx-search) `SphinxClient` 这个类中有很多 `set` 方法，我想这就和上面的 PHP 扩展的内容差不多，省去了安装扩展库。

```bash
composer require nilportugues/sphinx-search
```

```php
<?php

$sphinxSearch = new \NilPortugues\Sphinx\SphinxClient();

//Do connection and set up search method...
$sphinxSearch->setServer('127.0.0.1',9312);


// Do search...
// Result would contain "The Amazing Spider-Man 2", to be in theatres in 2014.
$sphinxSearch->setFilter('year',array(2014));
$result = $sphinxSearch->query('Spiderman','movies');

// Unset the filter to stop filtering by year
// Now we'll get all the Spiderman movies.
$sphinxSearch->removeFilter('year');
$result = $sphinxSearch->query('Spiderman','movies');
```

## Rerferences

- [How To Install and Configure Sphinx on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-sphinx-on-ubuntu-14-04)
