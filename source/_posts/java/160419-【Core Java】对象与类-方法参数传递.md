---
title: 【Core Java】对象与类-方法参数传递
permalink: core-java-method-parameter
date: 2016-04-19 20:00:00
updated:
tags:
  - java
  - reading-notes
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

提问：Java 对象采用的是值传递还是引用传递？

有些程序员认为 Java 对象采用的是引用调用，实际上，这种理解是不对的。下面给出一个反例来详细的阐述一下这一问题。

首先，编写一个交换两个雇员对象的方法：

```java
public static void swap(Employee x, Employee y)
{
   Employee temp = x;
   x = y;
   y = temp;
}
```

<!-- more -->

如果 Java 程序时引用调用，那么这个方法就应该能都实现交换实际的效果。

```java
System.out.println("\nTesting swap:");

Employee a = new Employee("Alice", 70000);
Employee b = new Employee("Bob", 60000);

System.out.println("Before: a=" + a.getName());
System.out.println("Before: b=" + b.getName());

swap(a, b);

System.out.println("After: a=" + a.getName());
System.out.println("After: b=" + b.getName());
```

但是结果 a 仍然时 Alice，b 是 Bob。对象引用进行的是值传递。

其实不必取扣是值传递还是引用传递的字眼，理解其中的原因是最好。

![160419-core-java-method-parameter-001](https://user-images.githubusercontent.com/9289792/80198302-72d19700-8652-11ea-9ddf-595a2be198b5.jpg)

在调用 swap 时，a 将一个 **引用的副本** 传递给了 x，让 x 也指向了，相同与 a 指向的内存单元中的 Employee 对象 Alice，b 将一个引用的副本传递给了 y，让 y 也指向了，相同与 b 指向的内存单元中的 Employee 对象 Bob。

这时执行 swap 方法内部的内容，交换了 x，y 的引用指向，这是 x 指向的时 Bob，y 是 Alice，但是在方法结束后，方法外的 a，b 的指向是仍然没有变化，a 是 Alice，b 是 Bob。

## 书上总结

一个方法不能修改一个基本数据类型的参数。
一个方法可以改变一个对象参数的状态。
一个方法不能让对象参数引用一个新的对象。

-- EOF --
