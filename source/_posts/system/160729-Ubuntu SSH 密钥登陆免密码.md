---
title: Ubuntu SSH 密钥登陆免密码
permalink: ubuntu-ssh-key-login-without-password
date: 2016-07-29 10:00:00
updated: 2018-01-14 11:00:00
comments: true
toc: true
tags:
   - ubuntu
   - ssh
description:
---

最近有需求使用 SSH 进行通信，而且要需免密码，总结了 SSH 密钥登陆免密码的方法。

## 快速配置

本机ip：192.168.1.1
服务器ip：192.168.1.2
欲实现本机免密码登录服务器，执行如下命令：

```
ssh-copy-id username@192.168.1.2
```

如果命令成功，则说明配置成功。如果执行失败，则需要参考下面的步骤进行配置。

<!-- more -->

## 本地配置方法
### 客户端生成公钥、私钥

```
ssh-keygen -t rsa -P ''
```

`-t` 表示 `key` 的类型，`-P` 表示密码，`-P ''` 就表示空密码，也可以不用 `-P` 参数，这样就要三车回车，用 `-P` 就一次回车。运行完之后在 `~/.ssh` 目录下生成私钥 `id_rsa` 和公钥` id_rsa.pub`。

### 将公钥添加到服务器

将客户端公钥 id_rsa.pub 复制到服务端。

```
scp ~/.ssh/id_rsa.pub user@192.168.1.140:~
```

将上传到服务端的公钥添加到 `~/.ssh/authorzied_keys` 之中。

```
cat ~/id_rsa.pub >> ~/.ssh/authorized_keys
```

如果没有这个 `authorzied_keys` 文件，可以创建一个。

### 设置文件权限

```
sudo chmod 755 ~/.ssh
sudo chmod 600 ~/.ssh/authorized_keys
```

### 设置用户以证书登录后，使用 sudo 操作

```
$ sudo visudo
```

```
%sudo ALL=(ALL:ALL) ALL

# 将上一行替换为：

%sudo ALL=(ALL) NOPASSWD:ALL
```

### 客户端以私钥 id_rsa 登录

SSH 证书登录命令：

```
ssh -i ~/.ssh/id_rsa username@<ssh_server_ip>
```

SCP 远程拷贝命令：

```
scp -i ~/.ssh/id_rsa filename username@<ssh_server_ip>:/username
```

**Tips：还是需要密码登陆**

我在这里遇到了一个问题，就是登陆时还是需要密码，注销后再登陆问题解决。

## 类似 AWS PEM 配置方法

亚马逊 AWS 虚拟服务器使用一个预先生成的 `*.pem` 证书文件（密钥）为客户端和服务器之间建立连接。

例如：

```
$ ssh -i ~/ec2.pem ubuntu@12.34.56.78
```

首先确定你可以以密码的形式连接远程服务器，也可以 [创建一个非超级管理员用户，并增加 sudo 权限](http://blog.csdn.net/hanshileiai/article/details/51141854)。

```
$ sudo ssh root@12.34.56.78
```

生成 `.pem` 步骤如下

### 客户端生成验证没有密码密钥对

```
$ ssh-keygen -t rsa -b 2048 -v
```

执行上述命令首先会让你输入生成密钥的文件名：我这里输入的 `myPemKey` 之后一路回车。

```
Generating public/private rsa key pair.
Enter file in which to save the key (/home/anonymouse/.ssh/id_rsa): myPemKey
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in hetzner.
Your public key has been saved in hetzner.pub.
The key fingerprint is:
bb:c6:9c:ee:6b:c0:67:58:b2:bb:4b:44:72:d3:cc:a5 localhost@localhost
The key's randomart image is:
```

在执行命令的当前目录下会生成一个 `myPemKey.pub`、`myPemKey` 两个文件。

### 服务端添加公钥

把生成的 `myPemKey.pub` 通过本地命令推送到服务器端，使服务器自动添加认证这个证书

```
$ ssh-copy-id -i ~/myPemKey.pub root@12.34.56.78
```

输入你的 `root` 用户密码

### 测试连接

```
$ sudo ssh -i ~/myPemKey root@12.34.56.78
```

或者把 `myPemKey` 重命名为 `myPemKey.pem`

```
$ sudo ssh -i ~/myPemKey.pem root@12.34.56.78
```

### 禁用密码连接

**注意：要保证 .pem 连接成功的状态下，禁用密码连接。**

```
$ sudo vi /etc/ssh/sshd_config
```

找到这一行 `#PasswordAuthentication yes` 取消前边的 # 注释，改为：

```
PasswordAuthentication no
```

重启 ssh 服务

```
$ sudo service ssh restart
```

> Reference:
> - [Better-ubuntu配置SSH免密码登录](http://bosschow.github.io/2016/03/31/ubuntu-ssh-without-passwd-login/)
> - [韩世磊-ubuntu 生成 .pem 证书连接服务器，取消OpenSSH密钥密码认证](http://blog.csdn.net/hanshileiai/article/details/51141638)
> - [韩世磊-ubuntu ssh 证书登录（不输入密码）](http://blog.csdn.net/hanshileiai/article/details/50381467)
