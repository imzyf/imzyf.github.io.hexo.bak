---
title: 使用 MailChimp API 3.0 的分页查询
permalink: work-with-mailchimp-api-3-0s-pagination
date: 2017-07-06 15:00:00
comments: true
toc: true
tags:
   - mailchimp
description:
---
## Situation
在使用 GET 调用 MailChimp 数据时，发现只返回了 10 条数据，这肯定是不合需求的，所以开始寻找分页查询的方法

## Solution
In order to get more than 10 items or start from a particular item, count and offset parameters need to be applied when calling HTTP GET.

For example, in order to get more than 10 lists (e.g. get 500 lists at once), append the `count=500` to the uri like this:
```
https://us10.api.mailchimp.com/3.0/lists?count=500
```

In order to get items from the 11th entry and ignore the first 10 items, append the `offset=10` to the uri as query string like this:
```
https://us10.api.mailchimp.com/3.0/lists?offset=10
```

```
var uri = string.Format("https://{0}.api.mailchimp.com/3.0/lists/{1}/members?offset={2}&count={3}",
    dataCenter, listId, offset, numberPerBatch);
```

<!-- more -->

> Reference:
> - [Work with MailChimp API 3.0&#39;s pagination | Yi Zeng’s Blog](http://yizeng.me/2016/04/30/work-with-mailchimp-api-3-0s-pagination/)
