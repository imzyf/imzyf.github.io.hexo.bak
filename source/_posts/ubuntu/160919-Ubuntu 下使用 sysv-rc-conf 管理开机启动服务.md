---
title: Ubuntu 下使用 sysv-rc-conf 管理开机启动服务
permalink: manage-startup-program-using-sysv-rc-conf-in-ubuntu
date: 2016-09-19 14:00:00
comments: true
toc: true
tags:
   - ubuntu
description:
---
`sysv-rc-conf` gives an easy to use interface for managing "/etc/rc{runlevel}.d/" symlinks. The interface comes in two different flavors, one that simply allows turning services on or off and another that allows for more fine tuned management of the symlinks.

## 安装 sysv-rc-conf
``` bash
sudo apt-get install sysv-rc-conf
```

## 使用 sysv-rc-conf
``` bash
sudo sysv-rc-conf
```
操作界面十分简洁，你可以用鼠标点击，也可以用键盘方向键定位，用空格键选择，用 `Ctrl+n` 翻下一页，用 `Ctrl+p` 翻上一页，用 `q` 退出。

<!-- more -->

## 相关知识
### 1、Ubuntu 运行级别
Linux 系统任何时候都运行在一个指定的运行级上，并且不同的运行级的程序和服务都不同，所要完成的工作和要达到的目的都不同，系统可以在这些运行级之间进行切换，以完成不同的工作。

Ubuntu 的系统运行级别：
```
0 停机
1 单用户，Does not configure network interfaces, start daemons, or allow non-root logins
2 多用户，无网络连接 Does not configure network interfaces or start daemons
3 多用户，启动网络连接 Starts the system normally.
4 用户自定义
5 多用户带图形界面
6 重启
```

查看当前运行级别，执行命令：
``` bash
runlevel
```
runlevel 显示上次的运行级别和当前的运行级别，“N”表示没有上次的运行级别。

切换运行级别，执行命令：
``` bash
int [0123456Ss]
```
即在 init 命令后跟一个参数，此参数是要切换到的运行级的运行级代号，如：用 init 0 命令关机；用 init 6 命令重新启动。

``` bash
ls /etc/rc*
```
对于以K开头的文件，系统将终止对应的服务；
对于以S开头的文件，系统将启动对应的服务；

### 2、Linux 系统主要启动步骤
1、读取 MBR 的信息，启动 Boot Manager
Windows 使用 NTLDR 作为 Boot Manager，如果您的系统中安装多个版本的 Windows，您就需要在 NTLDR 中选择您要进入的系统。Linux 通常使用功能强大，配置灵活的 GRUB 作为 Boot Manager。
2、 加载系统内核，启动 init 进程
init 进程是 Linux 的根进程，所有的系统进程都是它的子进程。
3、init 进程读取 /etc/inittab 文件中的信息，并进入预设的运行级别，按顺序运行该运行级别对应文件夹下的脚本。脚本通常以 start 参数启动，并指向一个系统中的程序。
通常情况下， /etc/rcS.d/ 目录下的启动脚本首先被执行，然后是/etc/rcN.d/ 目录。例如您设定的运行级别为 3，那么它对应的启动目录为 /etc/rc3.d/ 。
4、根据 /etc/rcS.d/ 文件夹中对应的脚本启动 Xwindow 服务器 xorg Xwindow 为 Linux 下的图形用户界面系统。
5、启动登录管理器，等待用户登录 Ubuntu 系统默认使用 GDM 作为登录管理器，您在登录管理器界面中输入用户名和密码后，便可以登录系统。（您可以在 /etc/rc3.d/文件夹中找到一个名为 S13gdm 的链接）

## 常见的系统服务
```
acpi-support 高级电源管理支持
acpid acpi 守护程序。这两个用于电源管理，非常重要
alsa 声音子系统
alsa-utils
anacron cron 的子系统，将系统关闭期间的计划任务，在下一次系统运行时执行
apmd acpi 的扩展
atd 类似于 cron 的任务调度系统。建议关闭
binfmt-support 核心支持其他二进制的文件格式。建议开启
bluez-utiles 蓝牙设备支持
bootlogd 启动日志。开启它
cron 任务调度系统，建议开启
cupsys 打印机子系统
dbus 消息总线系统(message bus system)。非常重要
dns-clean 使用拨号连接时，清除 dns 信息
evms 企业卷管理系统(Enterprise Volumn Management system)
fetchmail 邮件用户代理守护进程，用于收取邮件
gdm gnome 登录和桌面管理器。
gdomap
gpm 终端中的鼠标支持
halt 别动它
hdparm 调整硬盘的脚本，配置文件为 /etc/hdparm.conf
hibernate 系统休眠
hotkey-setup 笔记本功能键支持。支持类型包括: HP， Acer， ASUS， Sony，Dell， 和 IBM
hotplug and hotplug-net 即插即用支持，比较复杂，建议不要动它
hplip HP 打印机和图形子系统
ifrename 网络接口重命名脚本。如果您有十块网卡，您应该开启它
inetd 在文件 /etc/inetd.conf 中，注释掉所有你不需要的服务。如果该文件不包含任何服务，那关闭它是很安全的
klogd 重要
linux-restricted-modules-common 受限模块支持
/lib/linux-restricted-modules/ 文件夹中的模块为受限模块。例如某些驱动程序，如果您没有使用受限模块，就不需要开启它
lvm 逻辑卷管理系统支持
makedev 创建设备文件，非常重要
mdamd 磁盘阵列
module-init-tools 从/etc/modules 加载扩展模块，建议开启
networking 网络支持。按 /etc/network/interfaces 文件预设激活网络，非常重要
ntpdate 时间同步服务，建议关闭
pcmcia pcmcia 设备支持
powernowd 移动 CPU 节能支持
ppp and ppp-dns 拨号连接
readahead 预加载库文件
reboot 别动它
resolvconf 自动配置 DNS
rmnologin 清除 nologin
rsync rsync 守护程序
sendsigs 在重启和关机期间发送信号
single 激活单用户模式
ssh ssh 守护程序。建议开启
stop-bootlogd 在 2，3，4，5 运行级别中停止 bootlogd 服务
sudo 检查 sudo 状态。重要
sysklogd 系统日志
udev & udev-mab 用户空间 dev 文件系统(userspace dev filesystem)。重要
umountfs 卸载文件系统
urandom 随机数生成器
usplash 开机画面支持
vbesave 显卡 BIOS 配置工具。保存显卡的状态
xorg-common 设置 X 服务 ICE socket。
adjtimex 调整核心时钟的工具
dirmngr 证书列表管理工具，和 gnupg 一起工作。
hwtools irqs 优化工具
libpam-devperm 系统崩溃之后，用于修理设备文件许可的守护程序。
lm-sensors 板载传感器支持
mdadm-raid 磁盘陈列管理器
screen-cleanup 清除开机屏幕的脚本
xinetd 管理其他守护进程的一个 inetd 超级守护程序
```

> Reference:
> - [Ubuntu下使用sysv-rc-conf管理服务 » 冰河的博客](https://www.binghe.org/2009/12/manage-services-using-sysv-rc-conf-in-ubuntu/)
> - [Ubuntu下使用sysv-rc-conf管理服务 - AderStep](http://blog.csdn.net/gatieme/article/details/45251389)
> - [启动 - Ubuntu中文](http://wiki.ubuntu.org.cn/%E5%90%AF%E5%8A%A8)
