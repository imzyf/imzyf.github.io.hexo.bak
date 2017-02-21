---
title: 【Core Java】对象与类-方法参数传递
date: 2016-04-19 20:04:00
tags: java
permalink: core-java-method-parameter
description: 提问：Java对象采用的是值传递还是引用传递？有些程序员认为Java对象采用的是引用调用，实际上，这种理解是不对的。下面给出一个反例来详细的阐述一下这一问题。
---
### 提问：Java对象采用的是值传递还是引用传递？
>有些程序员认为Java对象采用的是引用调用，实际上，这种理解是不对的。下面给出一个反例来详细的阐述一下这一问题。
>首先，编写一个交换两个雇员对象的方法：
>```
   public static void swap(Employee x, Employee y)
   {
      Employee temp = x;
      x = y;
      y = temp;
   }
```
>如果Java程序时引用调用，那么这个方法就应该能都实现交换实际的效果。
>```
      System.out.println("\nTesting swap:");
      Employee a = new Employee("Alice", 70000);
      Employee b = new Employee("Bob", 60000);
      System.out.println("Before: a=" + a.getName());
      System.out.println("Before: b=" + b.getName());
      swap(a, b);
      System.out.println("After: a=" + a.getName());
      System.out.println("After: b=" + b.getName());
```
>但是结果a仍然时Alice,b是Bob.
>对象引用进行的是值传递。

其实不必取扣是值传递还是引用传递的字眼，理解其中的原因是最好。

![][1]

在调用swap时，a将一个引用的副本传递给了x,让x也指向了,相同与a指向的内存单元中的Employee对象"Alice",
b将一个引用的副本传递给了y,让y也指向了,相同与b指向的内存单元中的Employee对象"Bob",
这时执行swap方法内部的内容，交换了x,y的引用指向，这是x指向的时"Bob",y是"Alice"，
但是在方法结束后，方法外的a,b的指向是仍然没有变化，a是"Alice"，b是"Bob。

### 书上总结为：
>一个方法不能修改一个基本数据类型的参数。
>一个方法可以改变一个对象参数的状态。
>一个方法不能让对象参数引用一个新的对象。


  [1]: http://7xs09x.com1.z0.glb.clouddn.com/1728744933.jpg
