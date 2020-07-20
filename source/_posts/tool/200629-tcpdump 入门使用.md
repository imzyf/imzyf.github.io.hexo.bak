---
title: tcpdump 入门使用
permalink: tcpdump-getting-started
date: 2020-06-29 10:24:16
updated:
tags:
  - linux
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1556228841-7c69921649bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=640&q=80
feature_img:
---

tcpdump 是 Unix/Linux 下的抓包工具，可以针对指定网卡、端口、协议进行抓包。

<!-- more -->

## 字太多不看

```bash
sudo tcpdump host api.test and tcp port 80 -A -nn
sudo tcpdump dst api.test and tcp port 80 -A
```

## 一举成名天下知

```bash
man tcpdump
```

## 获取适配器列表

```bash
tcpdump -D
tcpdump --list-interfaces

1.en0 [Up, Running]
2.p2p0 [Up, Running]
3.awdl0 [Up, Running]
4.llw0 [Up, Running]
5.utun0 [Up, Running]
6.utun1 [Up, Running]
7.utun2 [Up, Running]
8.en5 [Up, Running]
9.lo0 [Up, Running, Loopback]
10.bridge0 [Up, Running]
11.en1 [Up, Running]
12.en2 [Up, Running]
13.en3 [Up, Running]
14.en4 [Up, Running]
15.gif0 [none]
16.stf0 [none]
17.XHC0 [none]
18.XHC1 [none]
19.ap1 [none]
20.XHC20 [none]
21.VHC128 [none]
```

## 监听适配器

Listen on interface.

macOS 下监听适配器，必须使用 root 权限。

```bash
sudo tcpdump -i en0

sudo tcpdump -i 1
```

## 过滤监听适配器

### 过滤主机

```bash
# 抓取所有经过 en0，目的或源地址是 192.168.50.1 的网络数据
sudo tcpdump -i en0 host 192.168.50.1

# 源地址
sudo tcpdump -i en0 src host 192.168.50.1

# 目的地址
sudo tcpdump -i en0 dst host 192.168.50.1
```

### 过滤端口

```bash
sudo tcpdump -i en0 port 8080
```

### 过滤网段

```bash
sudo tcpdump -i en0 net 192.168
```

### 协议过滤

```bash
sudo tcpdump -i en0 tcp
sudo tcpdump -i en0 udp
sudo tcpdump -i en0 ip
sudo tcpdump -i en0 arp
sudo tcpdump -i en0 icmp
```

### 使用表达式

- 与：&& 或 and
- 或：|| 或 or
- 非：! 或 not

## 选项

tcpdump 默认只会截取前 96 字节的内容，要想截取所有的报文内容，可以使用 -s number， number 就是你要截取的报文字节数，如果是 0 的话，表示截取报文全部内容。

- -i any 监听所有的网卡
- -n 不要解析域名，会优先暂时主机的名字
- -nn 不展示主机名和端口名（比如 443 端口会被展示成 https）
- -A 只使用 ascii 打印报文的全部数据，不要和 -X 一起使用。截取 http 请求的时候可以用 sudo tcpdump -nSA port 80
- -X 同时用 hex 和 ascii 显示报文的内容
- -XX 同 -X，但同时显示以太网头部
- -S 显示绝对的序列号（sequence number），而不是相对编号
- -s 截取的包字节长度，默认情况下 tcpdump 会展示 96 字节的长度，要获取完整的长度可以用 -s0 或者 -s1600。
- -v, -vv, -vvv：显示更多的详细信息
- -c number 截取 number 个报文，然后结束

## Flags

> [tcpdump Flags | readthedocs](https://amits-notes.readthedocs.io/en/latest/networking/tcpdump.html#id2)

| TCP Flag | Flag    | Meaning                                                        |
| -------- | ------- | -------------------------------------------------------------- |
| SYN      | S       | Syn packet, a session establishment request. 一个会话建立请求  |
| ACK      | A       | Ack packet, acknowledge sender’s data. 确认发送方的数据        |
| FIN      | F       | Finish flag, indication of termination. 终止的的标识           |
| RESET    | R       | Reset, indication of immediate abort of conn. 指令立即中止     |
| PUSH     | P       | Push, immediate push of data from sender. 从发送方立即推送数据 |
| URGENT   | U       | Urgent, takes precedence over other data. 优先于其他数据       |
| NONE     | A dot . | Placeholder, usually used for ACK. 占位符，通常用于 ACK        |

## 实例

抓取所有经过 eth1，目的地址是 192.168.1.254 或 192.168.1.200 端口是 80 的 TCP 数据：

```bash
sudo tcpdump -i eth1 '((tcp) and (port 80) and ((dst host 192.168.1.254) or (dst host
192.168.1.200)))'
```

抓取所有经过 eth1，目的网络是 192.168，但目的主机不是 192.168.1.200 的 TCP 数据：

```bash
sudo tcpdump -i eth1 '((tcp) and ((dst net 192.168) and (not dst host 192.168.1.200)))'
```

只抓 SYN 包：

```bash
sudo tcpdump -i eth1 'tcp[tcpflags] = tcp-syn'
```

抓 SYN, ACK：

```bash
sudo tcpdump -i eth1 'tcp[tcpflags] & tcp-syn != 0 and tcp[tcpflags] & tcp-ack != 0'
```

抓 DNS 请求数据：

```bash
sudo tcpdump -i en0 udp dst port 53
```

-c 参数对于运维人员来说也比较常用，因为流量比较大的服务器，靠人工 CTRL+C 还是抓的太多，于是可以用 -c 参数指定抓多少个包：

```bash
sudo time tcpdump -nn -i en0 'tcp[tcpflags] = tcp-syn' -c 10000 > /dev/null
```

实时抓取端口号 8000 的 GET 包，然后写入 GET.log：

```bash
sudo tcpdump -i eth0 '((port 8000) and (tcp[(tcp[12]>>2):4]=0x47455420))' -nnAl -w /tmp/GET.log
```

## 三次握手 四次挥手

### TCP 连接建立（三次握手）

客户端 A，服务器 B，初始序号 seq，确认号 ack。

初始状态：B 处于监听状态，A 处于打开状态。

- A -> B : seq = x （A 向 B 发送连接请求报文段，A 进入同步发送状态 SYN-SENT）
- B -> A : ack = x + 1,seq = y （B 收到报文段，向 A 发送确认，B 进入同步收到状态 SYN-RCVD）
- A -> B : ack = y + 1 （A 收到 B 的确认后，再次确认，A 进入连接状态 ESTABLISHED）

连接后的状态：B 收到 A 的确认后，进入连接状态 ESTABLISHED。

为什么要握手要三次？防止失效的连接请求突然传到服务器端，让服务器端误认为要建立连接。

### TCP 连接释放（四次挥手）

- A -> B : seq = u （A 发出连接释放报文段，进入终止等待 1 状态 FIN-WAIT-1）
- B -> A : ack = u + 1,seq = v （B 收到报文段，发出确认，TCP 处于半关闭，B 还可向 A 发数据，B 进入关闭等待状态 WAIT）
- B -> A : ack = u + 1,seq = w （B 重复发送确认号，进入最后确认状态 LAST-ACK）
- A -> B : ack = w + 1,seq = u + 1 （A 发出确认，进入时间等待状态 TIME-WAIT）

经过时间等待计时器设置的时间 2MSL 后，A 才进入 CLOSED 状态。

为什么 A 进入 TIME-WAIT 后必须等待 2MSL：

- 保证 A 发送的最后一个 ACK 报文段能达到 B
- 防止失效的报文段出现在连接中

### 需要思考的问题

问题 1: 请详细描述三次握手和四次挥手的过程
要求熟悉三次握手和四次挥手的机制，要求画出状态图。

问题 2: 四次挥手中 TIME_WAIT 状态存在的目的是什么?
这个问题是画出四次挥手状态图，会引申问你。不排除还会问为什么四次挥手是四次不是二次等问题。最好是把相关问题均掌握。

问题 3: TCP 是通过什么机制保障可靠性的?
从四个方面进行回答，ACK 确认机制、超时重传、滑动窗口以及流量控制，深入的话要求详细讲出流量控制的机制。

### 抓包分析握手过程

```bash
sudo tcpdump -i en0 host www.qq.com and tcp -S -c 50
```

![tcpdump 抓包分析握手过程](https://user-images.githubusercontent.com/9289792/87918568-3377e280-caa9-11ea-831a-95000e308ad8.png)

## References

- [macOS 下使用 tcpdump 抓包 | jianshu](https://www.jianshu.com/p/a57a5b0e58f0)
- [tcpdump | readthedocs](https://amits-notes.readthedocs.io/en/latest/networking/tcpdump.html)
- [TCP 三次握手、四次挥手与 TcpDump 抓包分析 | 清泉白石](https://www.cnblogs.com/fonxian/p/6565209.html)

-- EOF --
