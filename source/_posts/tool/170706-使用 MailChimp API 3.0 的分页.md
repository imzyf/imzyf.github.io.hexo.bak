---
title: 使用 MailChimp API 3.0 的分页查询
permalink: work-with-mailchimp-api-3-pagination
date: 2017-07-06 15:00:00
comments: true
toc: true
tags:
   - mailchimp
description:
---

## Situation

在使用 GET 调用 MailChimp 数据时，发现只返回了 10 条数据，这肯定是不合需求的，所以开始寻找分页查询的方法

<!-- more -->

## Solution

当调用 HTTP GET API 时为了得到超过 10 条（例如：500 条）的数据可以在 uri 添加 `count=500`：

```
https://us10.api.mailchimp.com/3.0/lists?count=500
```

为了得到第 11 个 entry 而忽略之前的 10 项，可以在 uri 添加 `offset=10`：

```
https://us10.api.mailchimp.com/3.0/lists?offset=10
```

```
var uri = string.Format("https://{0}.api.mailchimp.com/3.0/lists/{1}/members?offset={2}&count={3}",
    dataCenter, listId, offset, numberPerBatch);
```

> Reference:
>
> - [Work with MailChimp API 3.0&#39;s pagination | Yi Zeng’s Blog](http://yizeng.me/2016/04/30/work-with-mailchimp-api-3-0s-pagination/)
