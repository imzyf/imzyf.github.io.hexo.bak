---
title: Ubuntu crontab 内容定时备份
permalink: ubuntu-crontab-content-backup
date: 2017-03-07 12:00:00
comments: true
toc: true
tags:
   - ubuntu
   - crontab
description:
---

`crontab -r` 是一个很危险的命令，它将直接重置 crontab 中的内容；输入 `crontab` 后，使用 `ctrl + d` 退出也将清空 crontab 中的内容。所以 crontab 内容的定时备份也变得有必要了。

## 备份脚本

`crontab_bak.sh`

```bash
#!/bin/bash
crontab -l > /home/tom/crontab_bak/bak`date '+%Y%m%d'`.txt
```

config in crontab

```
12 12 * * * /bin/bash /home/tom/crontab_bak/crontab_bak.sh
```

<!-- more -->

## crontab 常用命令

```
crontab -l  # 列举 crontab 的任务
crontab -e  # 编辑 crontab 的任务
crontab -r  # 删除 crontab 的任务；风险
crontab -h  # crontab 的帮助
crontab -i  # 删除 crontab 前进行提示
```

-- EOF --
