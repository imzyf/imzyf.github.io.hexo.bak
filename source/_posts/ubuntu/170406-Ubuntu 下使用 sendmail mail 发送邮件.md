---
title: Ubuntu 下使用 sendmail mail 发送邮件
permalink: using-sendmail-mail-in-ubuntu
date: 2017-04-06 11:00:00
comments: true
toc: true
tags:
   - ubuntu
description:
---

&emsp;&emsp;使用邮件发送程序的执行情况、运行日志都非常方便。Ubuntu 下搭建邮件服务也不复杂
<!-- more -->
## sendmail
### install
``` bash
sudo apt-get install sendmail
```

### configure
run sendmail's config and answer `Y` to everything
``` bash
sudo sendmailconfig
```

## mail
### install
``` bash
sudo apt-get install mailutils
```

## test
``` bash
echo 'test-email-content' | mail -s 'email title' xxx@gmail.com
```

## sendmail mail 区别

&emsp;&emsp;先需要搞清三个概念：

- 邮件用户代理（MUA，Mail User Agent）
- 邮件传送代理（MTA，Mail Transport Agent）
- 邮件分发代理（MDA，Mail Deliver Agent）

&emsp;&emsp;sedmail 是负责邮件传输的 MTA，类似 apache、nginx 的作用
&emsp;&emsp;mail 是用户使用客户端 MUA，类似 foxmail

> reference:
> - [Install and configure Sendmail on Ubuntu](https://gist.github.com/adamstac/7462202)
> - [Linux 下 mail、mailx 和 sendmail 的区别？ - 知乎](https://www.zhihu.com/question/19728556)
