---
title: Docker UFW 失效
permalink: docker-ufw-not-work
date: 2018-04-24 14:00:00
updated:
tags:
  - docker
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

今日遇到 Docker 中的项目绕过了宿主机 UFW 的配置，可以被任意 IP 访问，甚是奇怪。查找资料发现：

如果你在 Linux 使用 Docker，很可能你的系统防火墙降级为 Uncomplicated Firewall (UFW)。如果是这样的话，你有一点可能不知道，Docker 和 UFW 的组合带来了一些安全问题。为什么呢？因为 Docker 实际上绕过了 UFW 并直接修改了 iptables，所以一个容器可以绑定一个端口。这就意味着，所有你设置的 UFW 规则都将在 Docker 容器中失效。

如何修复：

```bash
$ sudo vi /etc/default/docker

# add the following line:

DOCKER_OPTS="--iptables=false"
```

<!-- more -->

Restart the docker daemon:

```bash
$ sudo systemctl restart docker

# or

$ docker/etc/init.d/docker restart
```

> When a problem arises, it only takes a bit of digging to discover the solution was already there, waiting for you to make it so. Don't let this issue with Docker stop you from using this incredible technology.

相关阅读：

- [Yifans_Z Ubuntu 下使用 UFW 管理防火墙服务](/2016/10/10/manage-iptables-using-ufw-in-ubuntu/)

## References

> - [How to fix the Docker and UFW security flaw](https://www.techrepublic.com/article/how-to-fix-the-docker-and-ufw-security-flaw/)

-- EOF --
