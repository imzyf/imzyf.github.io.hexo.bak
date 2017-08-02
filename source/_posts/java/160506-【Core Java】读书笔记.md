---
title: 【Core Java】读书笔记
permalink: core-java-reading-notes
date: 2016-05-06 11:00:00
comments: true
toc: true
tags:
   - reading-notes
   - java
---
自己是第一次把一本厚厚的的技术类书读一遍。不过 7、8、9、10 章讲的是关于图形的就是翻了翻，没怎么看。第 4 章 对象与类，里面有很多非常基础，可以补充一些知识细节。第 14 章 多线程，是自己最陌生的，慕课网上有节课 [深入浅出Java多线程](http://www.imooc.com/view/202) 讲到的例子就是书上例子的变形，可以对照理解。第二遍阅读做做笔记。

本文总结的是书中的：第 3 章 Java 的基本程序设计结构、第 4 章 对象与类。

<!-- more -->

## 3 Java的基础程序设计结构
### 3.3 数据类型
- Java是一种强类型语音。在Java中，一共有8中基本类型（primitive type），其中有4种整型、2种浮点类型、1种用于表示Unicode编码的字符单元的字符类型char和1种用于表示真值的 boolean 类型。
- Java7开始，还可以为数字字面量加下划线，如用1_000_000表示一百万。这些下划线只是为了让人更易读。Java编译器会去除这些下划线。
- 浮点数值不适用于出现舍入误差的金融计算中。其主要原因时浮点数值采用二进制系统表示，而在二进制系统中无法精确的表示分数1/10。这就好像十进制无法精确地表示1/3一样。如果需要在数值计算中不含有任何舍入误差，就应该使用BigDecimal类。

### 3.4 变量
- 尽管$是一个合法的Java字符，但不要在自己的代码中使用这个字符。它只用在Java编译器或其他工具生成的名字中。

### 3.6 字符串
- 由于不能修改Java字符串中的字符，所以在Java文档中将String类对象称为不可变字符串。
- 如果虚拟机始终将相同的字符串共享，就可以使用 == 运算符检测是否相等。但实际上只有字符串常量是共享的，而 + 或者 substring 等操作产生的结果并不是共享的。因此，千万不要使用 == 运算符测试字符串的相等性，以免在程序中出现糟糕的 bug。从表面上看，这种 bug 很像随机产生的间歇性错误。

### 3.10 数组
- 在Java中，允许将一个数组变量拷贝给另一个数组变量。这时，两个变量将引用同一个数组：

``` java
int[] luckyNumbers = smallPrimes;
luckNumbers[5] = 12; // now smallPrimes[5] is also 12
```
- 如果希望将一个数组的所用值拷贝到一个新的数组中去，就要使用Arrays类的copyOf方法：

``` java
int[] copiedLuckyNumbers = Arrays.copyOf(luckyNumbers, luckyNumbers.length);
```

## 4 对象与类
### 4.1 面向对象程序设计概述
- 类之间的关系
依赖（uses-a）
聚合（has-a）
继承（is-a）
- 依赖（dependence），即 uses-a 关系。例如，Order 类使用 Account 类是因为 Order 对象需要访问 Account 对象查看信用状态。因此，如果一个类的方法操纵另一个类的对象，我们就说一个类依赖于另一个类。
应该尽可能的将相互依赖的类减至最少。我们如果A不知道B的存在，他就不会关心B的任何改变（这意味着 B 的改变不会导致 A 产生任何 bug）。用软件工程的术语来说，就是让类之间的耦合度最小。
- 聚合（aggressive），即 has-a 关系。例如，一个 Order 对象包含一些 Item 对象。聚合关系意味着类 A 的对象包含类 B 的对象。
- 继承（inheritance），即 is-a 关系。例如，RushOrder 类由 Order 类继承而来。在具有特殊性的 RushOrder 类中包含了一些用于优先处理的特殊方法，以及一个计算运费的不同方法；而其他的方法从 Order 类继承了来的。一般而言，如果类 A 扩展类 B，类 A 不但包含从类B继承的方法，还会拥有一些额外的功能。

### 4.2 使用预定义类
- 在对象与对象变量之间存在着一个重要的区别。例如：

``` java
Date deadline; // deadline doesn't refer to any object
```

- 定义了一个对象变量 deadline，它可以引用 Date 类型的对象。但是，一定要认识到：变量 deading 不是一个对象，实际上也没有引用对象。此时，不能将任何 Date 方法应用与这个变量上。

``` java
s = deadline.toString(); // not yet
```
- 必须首先初始化变量 deadline，可以用新构造的对象初始化这个变量，也可以让这个变量引用一个已存在的对象。
- 一定要认识到：一个对象变量并没有实际包含一个对象，而仅仅引用一个对象。
- 在 Java 中，任何对象变量的值都时对存储在另一个地方的一个对象的引用。new 操作符的返回值也是一个引用。
- 可显示地将对象变量设置为 null，表明这个对象变量目前没有引用任何对象。

### 4.3 用户自定义类
- 类文件必须与 public 类的名字相匹配。在一个原文件中，只能有一个共有类，但可以有任意数目的非共有类。
- 可以用 public 标记实例域，但这是一种极为不提倡的做法。public 数据域允许程序中的任何方法对其进行读取和修改。这就完全破坏了封装。这里强烈建议将实例域标记为 private。
- 构造器：
构造器与类同名
每个类可以有一个以上的构造器
构造器可以有0个、1个或多个参数
构造器没有返回值
构造器总是伴随着 new 操作一起调用
- 类：
私有的数据域
公有的域服务器方法
公有的域改变方法
- 不要编写返回引用可变对象的访问器方法。

``` java
class Employee {
    ...
    private Date hireDay;
    public Date getHireDay() {
        return Date hireDay;
    }
}
```
- 这样会破坏封装性！代码：

``` java
Employee harry = ...;
Date d = harry.getHireDay();
doule tenYearsInMilliSeconds = 10 * 365.25 * 24 * 60 * 60 * 1000;
d.setTime(d.getTime() - (long)tenYearsInMilliSeconds);
// let's give Harry ten years of added seniority
```

- 出错的原因很微妙。d 和 harry.hireDay 引用同一个对象。对 d 调用更改器方法就可以自动地改变这个雇员的私有状态！
- 如果需要返回一个可变对象的引用，应该首先对它进行克隆（clone）。对象 clone 是指存放在另一个位置上的对象副本。

``` java
    public Date getHireDay() {
        return Date hireDay.clone();
    }
```
- Employee 类的方法可以访问 Emloyee 类的任何一个对象的**私有域 ** 。

``` java
class Employee {
    public boolen equals(Employee other) {
        return name.equals(other.name);
    }
}
```
- final 修饰符大都应用于基本（primitive）类型域，或不可变（immutable）类的域（如果类中的每个方法都是不会改变其对象，这中类就是不可变的类。例如，String 类就是一个不可变的类）。对于可变的类，使用 final 修饰符可能会对读者造成混乱。代码

``` java
private final Date hiredate;
```
- 仅仅意味着存储子 hiredate 变量中的对象引用在对象构造之后不能被改变，而并不意味着 hiredate 对象是一个常量。任何方法都可以对 hiredate 引用的对象调用 setTime 更改器。

### 4.4 静态域与静态方法
- 每一个雇员对象都有一个自己的 id 域，但这个类的所有实例将共享一个 nextId 域。

``` java
class Employee {
    private static int nextId = 1;
    private int id;
}
```
- 换句话说，如果有1000个 Employee 类的对象，则有1000个实例域 id。但是，这有一个静态域 nextId。即使没有一个雇员对象，静态域 nextId 也是存在。它属于类，而不属于任何独立的对象。
- 可以使用对象调用静态方法。例如，如果 harry 是一个 Employee 对象，可以用 harry.getNextId() 代替 Employee.getNextId()。不过这中方式很容易造成混淆，其原因是 getNextId 方法计算的结果与 harry 毫无关系。我们建议使用类名来调用静态方法。
- 每一个类可以有一个 main 方法。这是一个常用于对类进行单元测试的技巧。

### 4.5 参数方法
- Java 程序设计语言总是采用按值调用。也就是说，方法得到的是所有参数值的一个拷贝。
- Java 程序设计语言中方法参数的使用情况：
一个方法不能修改一个基本数据类型的参数。
一个方法可以改变一个对象参数的状态。
一个方法不能让对象参数引用一个新的状态。

### 4.6 对象构造
- 要完整的描述一个方法需要指出方法以及参数类型，这叫做方法的签名（signature）。
- 返回类型不是方法签名的一部分。也就是说，不能有两个名字相同、参数类型也相同却返回不同类型值的方法。
- 如果在编写一个类时没有编写构造器，那么系统就会提供一个无参数构造器。这个构造器将所有的实例域设置为默认值。实例域中的数值类型数据设置为0、布尔型数值设置为 false、所有对象变量将设置为 null。
- 如果类中提供了至少一个构造器，但是没有提供无参数的构造器，则在构造对象时如果没有提供参数就会被视为不合法。
- 对每一个实例域都可以被设置为一个有意义的初值，这是一种很好的设计习惯。

``` java
class Employee {
    private String name = "";
    ...
}
```

### 4.10 类设计技巧
- 一定要保证数据私有。绝对不要破坏封装性。
- 一定要对数据初始化。
- 不要在类中使用过多的基本类型。就是说，用其他的类代替多个相关的基本类型的使用。
- 不是所有的域都需要独立的域访问器和域更改器。
- 将职责过多的类进行分解。
- 类名和方法名要能够体现它们的职责。
