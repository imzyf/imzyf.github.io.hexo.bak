---
title: 【Core Java】读书笔记 Part2
permalink: core-java-reading-notes-part2
date: 2016-09-23 16:00:00
comments: true
toc: true
tags:
   - java
   - reading notes
description:
---

&emsp;&emsp;本文总结的是书中的：第 5 章 继承；
&emsp;&emsp;前几章的总结在：[ZYF.IM-【Core Java】读书笔记 Part1](https://zyf.im/2016/05/06/core-java-reading-notes/)

## 5 继承

### 5.1 类、超类和子类
1、有些人认为 `super` 与 `this` 引用是类似的概念，实际上，这样比较并不太恰当。这是因为 `super` 不是一个对象的引用，不能将 `super` 赋予另一个对象变量，它只是一个指示编译器调用超类方法的特殊关键字。
2、使用 `super` 或 `this` 调用构造器的语句必须时子类构造器的第一条语句。也就是说 `super` 和 `this` 不能同时出现在一个构造器中。
3、`this` 关键字
 - 引用隐式参数
 - 调用该类其他的构造器

4、`super` 关键字
 - 调用超类的方法
 - 调用超类的构造器

5、调用构造器的语句只能作为另一个构造器的第一条语句出现。
6、一个对象变量可以指示多种实际类型的现象被称为多态。在运行时能够自动的选择则调用哪个方法的现象称为动态绑定。
7、`Manager[] managers = new Manager[10];` 将它转换成 `Employee[]` 数组是完全合法的：
`Employee[] staff = managers;// OK`
毕竟如果`manager[i]`是一个Manager，也一定是一个Employee，然而，实际上，将会发生一些令人惊讶的事情。要切记managers和staff引用的时同一个数组。现在请看：
`staff[0] = new Employee("Harry Hacker", ..);`
编译器竟然接纳了这个赋值操作。`staff[0]`与`manager[0]`引用的是同一个对象，似乎我们把一个普通雇员擅自归入了经理行列中了。这时一个种很忌讳发生的情形，当调用`managers[0].setBonus(1000)`的时候，将会导致调用一个不存在的实例域，今儿搅乱相邻存储空间的内容。
为了确保不发生这类错误，所有数组都要牢记创建它们的元素类型，并负责监督仅将类型兼容的引用存储到数组中。

8、调用对象方法的执行过程
- 编译器查看对象的声明类型和方法名。假设调用 x.f(param)，编译器将会一一列举所有 C 类中名为f的方法和其他超类中访问属性为 public 且名为f的方法（超类的私有方法不可访问）。
- 编译器将查看调用方法时提供的参数类型。如果在所有名为 f 的方法中存在一个与提供的参数类型完全匹配，就选择这个方法。这个工程称为重载解析。
- Tips：返回类型不是签名方法的一部分，因此，在覆盖方法时，一定要保证返回类型的兼容性。允许子类将覆盖方法的返回类型定义为原返回类型的子类型。
- 如果是 private 方法、static 方法、final 方法或者构造器，那么编译器将可以准确的知道应该调用哪个方法，我们将这种调用方式称为静态绑定。与此对应，调用的方法依赖于隐式参数的实际类型，并且在运行时实现动态绑定。

9、动态绑定与静态绑定区别对比
9.1）静态绑定发生在编译时期，动态绑定发生在运行时
9.2）使用private或static或final修饰的变量或者方法，使用静态绑定。而虚方法（可以被子类重写的方法）则会根据运行时的对象进行动态绑定。
9.3）静态绑定使用类信息来完成，而动态绑定则需要使用对象信息来完成。
9.4）重载(Overload)的方法使用静态绑定完成，而重写(Override)的方法则使用动态绑定完成。

 10、当程序运行，并且采用动态绑定调用方法时，虚拟机一定调用与 x 所引用对象的实际类型最合适的那个类的方法。假设x的实际类型是D，它是C类的子类。如果D类定义了方法 f(String)，就直接调用它；否则，将在D类的超类中寻找f(String)，以此类推。

11、每次调用方法都要进行搜索，时间开销相当大。因此，虚拟机预先为每个类创建了一个方法表，其中列出了所有方法的签名和实际调用的方法。这样一来，在真正调用方法的时候，虚拟机仅查找这个表就行了。


### 5.1 类、超类和子类
1、4个访问修饰符
- 仅对本类可 —— private
- 对所有类可见 —— publice
- 对本包和所有子类可见 —— protected
- 对本包可见 —— 默认，不需要修饰符

2、编写一个完美的 equals 方法的建议
2.1）参数命名为 otherObject，稍后需要将它转换成另一个叫做 other 的变量
2.2）检测 this 与 otherObject 是否引用同一个对象：
&emsp;&emsp;`if(this == otherObject) return true;`
&emsp;&emsp;这条语句只是一个优化。实际上，这是一种经常采用的形式。因为计算这个等试要比一个一个的比较类中的域付出的代价小得多。
2.3）检测 otherObject 是否为 null，如果为 null，返回 false。这项检测时很有必要的。
&emsp;&emsp;`if(otherObject == null) return false;`
2.4）比较 this 与 otherObject 是否属于同一个类。如果 equals 的语义在每一个子类中有所改变（子类能够拥有自己的相等概念），就使用 getClass 检测：
&emsp;&emsp;`if(getClass() != otherObject.getClass()) return false;`
&emsp;&emsp;如果所有的子类都拥有统一的语义（由超类决定相等的概念）就使用 instanceof 检测：
&emsp;&emsp;`if(!(otherObject instanceof ClassName)) return false;`
2.5）将 otherObject 转换为相应的类类型变量
&emsp;&emsp;`ClassName other = (ClassName)otherObject;`
2.6）现在开始对所有需要比较的域进行比较了。使用 == 比较基本类型域，使用 equals 比较对象域。如果所有的域都匹配，就返回 true；否则返回 false
2.7）完整的例子：
``` java
class Employee {
	...
	public boolean equals(Object otherObject) {
		// a quick test to see if the objects are identical
		if(this == otherObject) return true;

		// must return false if the explicit parameter is null
		if(otherObject == null) return false;

		// if the classes don`t match, they can`t be equal
		if(getClass() != otherObject.getClass()) return false;

		// now we know otherObject is a non-null values
		Emloyee other = (Emloyee)otherObject;

		// test whether the fields have identical values
		return name.equals(other.name) && salary == other.salary
			&& hrieDay.equals(other.hirDay);
	}
}
```


> Reference:
> - [技术小黑屋-Java中的静态绑定和动态绑定](http://droidyue.com/blog/2014/12/28/static-biding-and-dynamic-binding-in-java/)
