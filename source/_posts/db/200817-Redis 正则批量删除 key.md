---
title: Redis 正则批量删除 key
permalink: redis-matching-a-pattern-delete-keys
date: 2020-08-17 19:34:29
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

```lua
EVAL "return redis.call('del', 'defaultKey', unpack(redis.call('keys', ARGV[1])))" 0 prefix:*
```

循环删除：

```lua
EVAL "local keys = redis.call('keys', ARGV[1]) \n for i=1,#keys,5000 do \n redis.call('del', unpack(keys, i, math.min(i+4999, #keys))) \n end \n return keys" 0 prefix:*
```

## References

- [How to atomically delete keys matching a pattern using Redis | stackoverflow](https://stackoverflow.com/questions/4006324/how-to-atomically-delete-keys-matching-a-pattern-using-redis)

-- EOF --
