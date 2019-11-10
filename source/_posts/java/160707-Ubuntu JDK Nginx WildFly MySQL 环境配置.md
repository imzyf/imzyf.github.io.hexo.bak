---
title: Ubuntu JDK Nginx WildFly MySQL 环境配置
permalink: ubuntu-jdk-nginx-wildfly-mysql-config
comments: true
date: 2016-07-07 10:00:00
toc: true
tags:
  - java
description:
---

新项目部署上线，主要参考 [世雷博客](http://blog.csdn.net/hanshileiai) 的内容，自己也总结了下。从 JDK 安装、Web 容器、数据库，都有涉及比较全面。

## JDK8

### 安装 JDK8

1、添加软件源

```bash
sudo add-apt-repository ppa:webupd8team/java
```

2、更新软件源

```bash
sudo apt-get update
```

3、安装 jdk1.8

```bash
sudo apt-get install oracle-java8-installer
```

### 查看 Java 安装路径

```bash
sudo update-alternatives --config java
sudo update-alternatives --config javac
```

### 查看 Java 安装后的版本

```bash
java -version
```

### （扩展）增加多版本 JDK 和切换方法

1、安装 JDK 6 和 JDK 7

```bash
sudo apt-get install oracle-java6-installer
sudo apt-get install oracle-java7-installer
```

2、查看所有 JDK 安装版本

```bash
sudo update-java-alternatives -l
java-6-oracle 3 /usr/lib/jvm/java-6-oracle
java-7-oracle 4 /usr/lib/jvm/java-7-oracle
java-8-oracle 2 /usr/lib/jvm/java-8-oracle
```

3、通过 `-s` 参数可以方便的切换到其它的 JDK 版本

```bash
sudo update-java-alternatives -s java-6-oracle
```

```bash
sudo update-java-alternatives -s java-7-oracle
```

```bash
sudo update-java-alternatives -s java-8-oracle
```

4、再次查看 JDK 版本

```
java -version
```

```
java version "1.6.0_45"
Java(TM) SE Runtime Environment (build 1.6.0_45-b06)
Java HotSpot(TM) 64-Bit Server VM (build 20.45-b01, mixed mode)
```

<!-- more -->

## Nginx

### Nginx 安装

1、更新软件源

```
sudo apt-get update
```

2、安装 Nginx

```
sudo apt-get install nginx
```

3、查看 Nginx 位置

```
whereis nginx
```

### Nginx 禁止外网访问

防止 Google 收录

```
sudo vi /etc/nginx/sites-enabled/default
```

在 `server` 中添加

```
# server add
# 公司代理IP
allow *.*.*.*;
deny all;
```

### Nginx 域名调整

域名 `www` 跳转 `non www`，`server` 中添加配置

```
server_name www.aaa.org aaa.org;
if ($host != 'aaa.org'){
	rewrite ^/(.*)$ http://aaa.org/$1 permanent;
}
```

### Nginx GZip

```
##
# Gzip Settings
##

gzip on;
gzip_disable "msie6";

gzip_vary on;
gzip_min_length 1k;
gzip_proxied any;
gzip_comp_level 6;
gzip_buffers 16 8k;
gzip_http_version 1.1;
gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript application/x-httpd-php image/jpeg image/gif image/png image/x-icon
```

### Nginx 静态文件缓存

```
location ~*\.(gif|jpg|jpeg|png|bmp|swf|woff|icon)$ {
	proxy_cache my_zone;
	proxy_cache_bypass $http_cache_control;
	proxy_cache_valid 200 1d;
	add_header X-Proxy-Cache $upstream_cache_status;
	expires 15d;
}

location ~ .*\.(js|css|ttf)$ {
	proxy_cache my_zone;
	proxy_cache_bypass $http_cache_control;
	proxy_cache_valid 200 1d;
	add_header X-Proxy-Cache $upstream_cache_status;
	expires 15d;
}
```

静态文件放在配置的 `root` 下

```
root /opt/***;
```

还有个技巧，项目中大量资源文件，例如 PDF，在设计访问 url 时可以 `**/pdf/**`，这样在 Nginx 进行配置就可以将文件分离出项目；这些文件也放在 `root` 路径下。

```
location ^~ /html/ {
}
location ^~ /pdf/ {
}
```

### Nginx Commands

```
sudo service nginx stop
sudo service nginx start
sudo service nginx restart
```

### Nginx Show Log

```
sudo tail -f /var/log/nginx/error.log
```

## WildFly 10.0.0.Final

### WildFly 安装

1、下载 WildFly，并提取到 /opt 目录 WildFly 10.0.0.Final [下载地址](http://wildfly.org/downloads/)

```
cd /opt
sudo wget -c http://download.jboss.org/wildfly/10.0.0.Final/wildfly-10.0.0.Final.tar.gz
sudo tar -xzvf wildfly-10.0.0.Final.tar.gz
```

2、创建 WildFly 用户和组

```
sudo addgroup wildfly
sudo useradd -g wildfly wildfly
```

改变 wildfly 文件夹的所有权：

```
sudo chown -R wildfly:wildfly /opt/wildfly-10.0.0.Final
```

创建一个链接映射（好处：如果你改变 WildFly 版本,不需要更新其他配置）

```
sudo ln -s wildfly-10.0.0.Final /opt/wildfly
```

3、安装 init.d 脚本
设置并使用 init.d 脚本来启动和停止 WildFly。复制`/opt/wildfly/bin/init.d/wildfly-init-debian.sh`脚本到 `/etc/init.d/wildfly`，更改权限,并使其可执行

```
sudo cp /opt/wildfly/docs/contrib/scripts/init.d/wildfly-init-debian.sh /etc/init.d/wildfly
sudo chown root:root /etc/init.d/wildfly
sudo chmod ug+x /etc/init.d/wildfly
```

启动/停止 WildFly 命令

```
sudo /etc/init.d/wildfly start
sudo /etc/init.d/wildfly stop
```

4、WildFly 做为系统服务，开机启动

```
sudo update-rc.d wildfly defaults
```

### 配置 WildFly 允许所有 ip 访问

1、打开配置文件 `standalone.xml`

```
sudo vi /opt/wildfly/standalone/configuration/standalone.xml
```

2、替换此处

```
<interface name="management">
    <inet-address value="${jboss.bind.address.management:127.0.0.1}"/>
</interface>
<interface name="public">
    <inet-address value="${jboss.bind.address:0.0.0.0}"/>
</interface>
```

改为

```
<interface name="management">
    <any-address/>
</interface>
<interface name="public">
    <any-address/>
</interface>
```

3、保存后，重新启动 WildFily

```
sudo service wildfly restart
```

### 删除默认欢迎内容（可选）

如果你部署了应用程序在上下文根目录里，欢迎你 将需要从 WildFly 配置删除默认内容。在 standalone.xml 文件里删除粗体突出显示的行

```
<server name="default-server">
    <http-listener name="default" socket-binding="http"/>
    <host name="default-host" alias="localhost">
        **<!-- <location name="/" handler="welcome-content"/> -->**
        <filter-ref name="server-header"/>
        <filter-ref name="x-powered-by-header"/>
    </host>
</server>
<handlers>
    **<!-- <file name="welcome-content" path="${jboss.home.dir}/welcome-content"/> -->**
</handlers>
```

### 其它设置

改为可以修改 JSP 页面不用重启

```
<servlet-container name="default">
      <jsp-config development="true"/>
</servlet-container>
```

### 注意事项

1、项目以站点根目录访问
你现在可以将应用程序部署到 WildFly 视图在 your_ip:8080
在你的项目目录 WEB-INF 下添加 jboss-web.xml，确保你的配置 context-root 设置为 /

```
<?xml version="1.0" encoding="UTF-8"?>
<jboss-web>
    <context-root>/</context-root>
</jboss-web>
```

2、Linux 里设置端口 80 到 8080
**注意：在之后的配置会使用 Nginx 反向代理，所用 WildFly 端口不用映射为 80，这里只是个方法的笔记**

注意，在 linux 里，由于内核的限制，普通用户不能使用 1024 一下的端口。所以在配置文件（standalone.xml）里改成 80，用普通用户是启动不了的。

此时，我们需要在 linux 下使用 root 用户运行一个命令，使访问 80 端口的应用转到 8080 上：

```
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080
```

以上端口转发为临时操作，重启 linux 服务器后失效。如果要重启服务器不丢失 FORWARD 转发”操作，可写入配置。

> 在 Linux 的下面部署了 tomcat，为了安全我们使用非 root 用户进行启动，但是在域名绑定时无法直接访问 80 端口号。众所周知，在 unix 下，非 root 用户不能监听 1024 以上的端口号，这个 tomcat 服务器就没办法绑定在 80 端口下。所以这里需要使用 linux 的端口转发机制，把到 80 端口的服务请求都转到 8080 端口上。

2.1、安装 iptables-persistent

```
sudo apt-get update
sudo apt-get install iptables-persistent
```

2.2、添加 80 端口跳转到 8080 规则

```
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
```

2.3、保存跳转规则

```
sudo service iptables-persistent save
```

3、wildfly 不支持 struts2 的配置文件（.xml）里用通配符
**这是原博文的内容，我没有使用 struts2；在 spring 中有用通配符，但是好像没什么影响**
jboss wildfly 不支持 struts2 配置文件里用通配符 `*.xml`，如下：

```
    <!-- <include file="struts/*.xml"></include> -->
    <include file="struts/struts_post.xml"></include>
    <include file="struts/struts_user.xml"></include>
```

4、增加部署扫描仪的超时设置
位置：

```
<subsystem xmlns="urn:jboss:domain:deployment-scanner:2.0">
    <deployment-scanner path="deployments" relative-to="jboss.server.base.dir" scan-interval="5000" />
</subsystem>
```

`<deployment-scanner>` 内增加属性 `deployment-timeout="1200"` 如下：

```
<subsystem xmlns="urn:jboss:domain:deployment-scanner:2.0">
    <deployment-scanner path="deployments" relative-to="jboss.server.base.dir" scan-interval="5000" deployment-timeout="1200" />
</subsystem>
```

### Nginx 反向代理 WildFly

1、在 `http` 中添加

```
upstream jboss {
	server 127.0.0.1:8080;
}
```

2、在 `server` 中修改

```
location /{
	proxy_pass http://jboss;
	proxy_redirect off;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header Host $http_host;
	index index.html index.htm index.jsp;
	# 动态网站要小心这个 缓存 选项
	add_header Cache-Control max-age=1728000;
}
```

## MySQL

### MySQL5.6 安装

```bash
sudo apt-get install mysql-server-5.6
```

### MySQL 创建数据库

```bash
CREATE DATABASE IF NOT EXISTS scrapy DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
```

### MySQL 数据库导出/导入

```bash
mysqldump -u root -p123456 db_name | gzip > /home/backup/db_name.sql.gz
mysqldump -u root -p123456 --all-databases | gzip > /home/backup/all.sql.gz

mysqldump -h192.168.1.100 -uroot -p db_name > db_name.sql
mysqldump -uroot -p db_name_1 db_name_2 > db_name_1_and_2.sql
```

```bash
gunzip < db_name.sql.gz | mysql -u root -p123456 db_name
gunzip < all.sql.gz | mysql -u root -p123456

mysql -uroot -p
show databases;
use db_name;
source ~/db_name.sql
```

### MySQL 查看表结构

```sql
desc user
```

## Project

### robots.txt config 禁止所有爬虫爬取

```
User-agent: *
Disallow: /
```

> Renference:
>
> - [韩世雷-ubuntu 配置 java jdk1.8 环境，增加多版本 jdk 和切换方法](http://blog.csdn.net/hanshileiai/article/details/46968275)
> - [韩世雷-ubuntu14.04 Terminal 配置 wildfly-10.0.0.Final 服务器](http://blog.csdn.net/hanshileiai/article/details/46987859)
> - [韩世雷-Ubuntu14.04 配置 iptables 把 80 端口转到 8080](http://blog.csdn.net/hanshileiai/article/details/47757217)
