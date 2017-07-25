---
title: Eclipse Java 注释模板
permalink: eclipse-java-comments-templates
date: 2016-09-18 19:00:00
comments: true
toc: true
tags:
   - eclipse
description:
---

自己总结的比较规范的 Eclipse Java 注释模板

## Eclipse Java 注释模板设置
Window -> Preference -> Java -> CodeStyle -> Code Template 然后展开 Comments 节点就是所有需设置注释的元素

<!-- more -->

## 各项注释模板
### Files
```
/**
 * Copyright © ${year}. All rights reserved.
 *
 * @Title: ${file_name}
 * @Prject: ${project_name}
 * @Package: ${package_name}
 * @Description: ${todo}
 * @author: ${user}
 * @date: ${date} ${time}
 */
```

### Types
```
/**
 *
 *
 * @ClassName: ${type_name}
 * @Description: ${todo}
 * @author: ${user}
 * @date: ${date} ${time}
 * ${tags}
 */
```

### Fields
```
/**
 * @fieldName: ${field}
 * @fieldType: ${field_type}
 * @Description: ${todo}
 */
```

### Constructors
```
/**
 * @Title:${enclosing_type}
 * @Description:${todo}
 * ${tags}
 */
```

### Methods
```
/**
 *
 *
 * @Title: ${enclosing_method}
 * @Description: ${todo}
 * @author: ${user}
 * ${tags}
 * @return: ${return_type}
 */
```

### Overriding methods
```
/* (no Javadoc)
 * <p>Title: ${enclosing_method}</p>
 * <p>Description: </p>
 * ${tags}
 * ${see_to_overridden}
 */
```

## 定制 ${user} 显示内容

找到你的 Eclipse 安装路径，打开 `eclipse.ini` 文件，在 -vmargs 下面添加
```
-Duser.name=姓名 + 空格 + 邮箱地址
```
