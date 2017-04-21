---
title: Ubuntu 下使用 UFW 管理防火墙服务
permalink: manage-iptables-using-ufw-in-ubuntu
date: 2016-10-10 13:00:00
comments: true
toc: true
tags:
   - ubuntu
   - ufw
description:
---

&emsp;&emsp;UFW (Uncomplicated Firewall) 作为 iptables 的前端应用，给用户提供了简单的接口界面。使用着不需要去记非常复杂的 iptables 语法。UFW 也使用了 简单英语 作为它的参数。像 allow、deny、reset 就是他们当中的一部分。UFW 绝对是那些想要快速、简单的就建立自己的防火墙，而且还很安全的用户的最佳替代品之一。
<!-- more -->

## 检查系统上是否已经安装 UFW
``` bash
sudo dpkg --get-selections | grep ufw
```

## 安装 UFW
``` bash
sudo apt-get install ufw
```

## UFW 常用命令
### 查看 UFW 状态
``` bash
sudo ufw status
```

### 启用/禁用 UFW
``` bash
# 启用
sudo ufw enable
# 禁用
sudo ufw disable
```
先添加 `ufw allow ssh`，防止墙掉自己

### 查看 UFW 规则
需要先启用 UFW
``` bash
sudo ufw status verbose
```
在每条规则上加个序号数字
``` bash
sudo ufw status numbered
```

### 添加 UFW 允许规则
#### 允许特定服务程序
``` bash
sudo ufw allow ssh
```

#### 允许特定服务程序特定协议
``` bash
sudo ufw allow ssh/tcp
```

#### 允许特定端口
``` bash
sudo ufw allow 8080
```

#### 允许特定端口特定协议
``` bash
sudo ufw allow 8080/tcp
```

#### 允许范围端口特定协议
必须指明协议 udp 或 tcp
``` bash
sudo ufw allow 2290:2300/tcp
```

#### 允许特定 IP
``` bash
sudo ufw allow from 192.168.0.104
```

#### 允许范围 IP
``` bash
sudo ufw allow from 192.168.0.0/24
```
> - [networking - UFW - allow range of IP addresees? - Ask Ubuntu](https://askubuntu.com/questions/646424/ufw-allow-range-of-ip-addresees)
> - [IPv4 subnetting reference - Wikipedia](https://en.wikipedia.org/wiki/IPv4_subnetting_reference)


#### 组合参数
可以把 IP 地址、协议和端口这些组合在一起用。
创建一条规则，限制仅仅来自于 192.168.0.104 的 IP ，而且只能使用 tcp 协议和通过 22 端口来访问本地资源：
```
sudo ufw allow from 192.168.0.104 proto tcp to any port 22
```

### 添加 UFW 拒绝规则
创建拒绝规则的命令和允许的规则类似，仅需要把 `allow` 参数换成 `deny` 参数就可以。
``` bash
sudo ufw deny ftp
```

### 删除 UFW 规则
#### 方法一
``` bash
sudo ufw delete allow ftp
```

#### 方法二：按行号删除
``` bash
# 显示行号
sudo ufw status numbered
```
``` bash
# 按行号删除
sudo ufw delete 1
```

### 重置 UFW 所有规则
```
sudo ufw reset
```

> reference:
> - [Debian/Ubuntu系统中安装和配置UFW－简单的防火墙-技术 ◆ 学习|Linux.中国-开源社区](https://linux.cn/article-2489-1.html)
