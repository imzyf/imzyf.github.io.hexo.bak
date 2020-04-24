---
title: Eclipse Maven 配置使用国内镜像库
permalink: eclipse-maven-settings-mirror-in-china
date: 2016-09-14 15:00:00
updated:
tags:
  - java
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

Windows 下因为 Eclipse 自带了 Maven 插件，还算够用就懒得安装 Maven 了。在不使用代理的情况下，用 Maven 的下载库不是一般的慢。Eclipse Maven 的插件怎么配置国内的镜像库呢？其实很简单。

<!-- more -->

## 创建 settings.xml 文件

注意两个地方：
1、`<localRepository>C:\Users\Lenovo\.m2\repository</localRepository>` 本地仓库位置
2、镜像配置，选取的是 aliyun 的

```xml
<mirrors>
  <mirror>
    <id>alimaven</id>
    <name>aliyun maven</name>
    <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
    <mirrorOf>central</mirrorOf>
  </mirror>
</mirrors>
```

完整的 settings.xml 文件

```xml
<?xml version="1.0" encoding="UTF-8"?>

<!--
 | This is the configuration file for Maven. It can be specified at two levels:
 |
 |  1. User Level. This settings.xml file provides configuration for a single user,
 |                 and is normally provided in ${user.home}/.m2/settings.xml.
 |
 |                 NOTE: This location can be overridden with the CLI option:
 |
 |                 -s /path/to/user/settings.xml
 |
 |  2. Global Level. This settings.xml file provides configuration for all Maven
 |                 users on a machine (assuming they're all using the same Maven
 |                 installation). It's normally provided in
 |                 ${maven.home}/conf/settings.xml.
 |
 |                 NOTE: This location can be overridden with the CLI option:
 |
 |                 -gs /path/to/global/settings.xml
 | |
 |-->
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

  <!--  Change in below line  -->
  <localRepository>C:\Users\Lenovo\.m2\repository</localRepository>

  <interactiveMode>true</interactiveMode>

  <offline>false</offline>

  <pluginGroups>
    <!-- pluginGroup
     | Specifies a further group identifier to use for plugin lookup.
    <pluginGroup>com.your.plugins</pluginGroup>
    -->
  </pluginGroups>

  <proxies>
    <!--
    <proxy>
      <id>optional</id>
      <active>true</active>
      <protocol>http</protocol>
      <username>proxyuser</username>
      <password>proxypass</password>
      <host>proxy.host.net</host>
      <port>80</port>
      <nonProxyHosts>local.net|some.host.com</nonProxyHosts>
    </proxy>
    -->
  </proxies>

  <servers>
    <!--
    <server>
      <id>deploymentRepo</id>
      <username>crunchify</username>
      <password>crunchify</password>
    </server>
 	-->
  </servers>

  <mirrors>
    <mirror>
        <id>alimaven</id>
        <name>aliyun maven</name>
    	<url>http://maven.aliyun.com/nexus/content/groups/public/</url>
	    <mirrorOf>central</mirrorOf>
     </mirror>
  </mirrors>

  <profiles>
  </profiles>

</settings>
```

## 设置 Eclipse Maven Plugin

Window -> Preferences -> Maven -> User Settings -> User settings Browse 选择上面创建的 `setting.xml` -> ok
