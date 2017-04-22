---
title: Java final 修饰符
permalink: java-modifier-final
comments: true
date: 2016-06-13 14:00:00
tags: java
description: final 修饰符表示不可变。类似 C 中的 constant。用于修饰变量表示不可变的变量。用于修饰方法表示不可被重写。用于修饰类表示不可被继承。
---
## final 修饰符
final 修饰符表示不可变。类似 C 中的 constant。用于修饰变量表示不可变的变量。用于修饰方法表示不可被重写。用于修饰类表示不可被继承。

## final 的成员变量
成员变量随着类或者实例的初始化而初始化。在类初始化时，静态变量就会被分配内存并初始化。对于实例变量，系统会在实例初始化的时候初始化这些变量。

由于成员变量会被系统隐式的初始化。如果程序员不显式的初始化它们，那他们会变成 0，false，null 这样的值。失去了意义。

所以 **final 修饰的成员变量必须显式的初始化。**

- 类变量：必须在静态初始化块，或者在声明的时候初始化
- 实例变量：必须在非静态初始化块，声明时，或者构造函数中初始化。

## final的局部变量
对于形参：在方法内部无法对其进行赋值。
方法体内的 final 局部变量：只能赋值一次。
final 的基本类型变量和引用类型变量

基本类型变量：值不可变。
引用类型变量：指针不可变，但是指向的内存区域可变。

``` java
public class FinalVariableTest {
	public static void main(String[] agrs){
		final int[] arr = {1,23,4,5};
		System.out.println(Arrays.toString(arr));
		arr[2] = 20;
        System.out.print(Arrays.toString(arr));
   }
}

//Console
//[1, 23, 4, 5]
//[1, 23, 20, 5]
```

## final 的宏替换

对于 final 的变量来说，不管是类变量，实例变量还是局部变量。只要在编译的时候可以确定，那么编译器就会把它看成一个直接量而不是变量。
比如:

``` java
public class FinalVar{
   public static void main(String[] args){
       final int a =5;
       System.out.println(a);
   }
}
```

实际编译器在执行 System.out.println(a);等同于执行 System.out.println(5);
**什么叫做编译时可以确定**
下面这个例子。
str1 在编译的时候就可以确定。而 str2 需要调用 valueOf() 方法才能得到后面一个字符串。在编译的时候无法确定。从结果也可以看出来。

``` java
final String str1 = "hello world"+2016;
final String str2 = "hello world"+String.valueOf(2016);

System.out.println(str1=="hello world2016");
System.out.println(str2=="hello world2016");
```

再看这个

``` java
String str1 = "hello world";
String str2 = "hello " + "world";

String s1 = "hello ";
String s2 = "world";

String str3 = s1 + s2;

System.out.println(str1 == str2);
System.out.println(str1 == str3);
```

str1 == str3 返回是 false。因为 str3 在编译是无法确定。所以不会被当作直接量。但是如 s1 和 s2 都加上 final。编译器会进行宏替换。str3 就等同于”hello “ + ”world”。

## final的方法

final 的方法不会被重写。

## final的类

final 的类不能被继承。

## 不可变类

Java 提供的基础变量类型的包装类和 String 类都是不可变类。如果要自己创建不可变的类需要注意几点：

- 使用 private 和 final 修饰成员变量。
- 提供带参数的构造器，用于根据需要传入参数来初始化类里的成员变量。
- 仅提供 getter 方法，不提供 setter 方法。
- 如果有必要重写 hashCode() 和 equals() 方法。还要保证两个用 equals 方法判断相等的对象 hasdCode() 也相等。

``` java
public class Address {
   private final String detail;
   private final String postCode;
   public Address(){
      this.detail="";
      this.postCode="";
   }
   public Address(String detail，String postCode){
       this.detail=detail;
       this.postCode=postCode;
   }
   public String getDetail(){
       return this.detail;
   }
   public String getPoetCode(){
       return this.postCode;
   }
   public boolean equals(Object obj){
       if(this == obj){
           return true;
       }
       if(obj!=null&&obj.getClass()==Address.class){
           Address ad = (Address)obj;
           if(this.getClass().equals(ad.getDetail())&&this.getPoetCode().equals(ad.getPoetCode())){
               return true;
           }
       }
       return false;
   }
   public int hashCode(){
       return this.detail.hashCode()+this.postCode.hashCode();
   }
}
```

编写不可变类的时候，只需要提供 getter 方法，不提供 setter 方法就可以了。但是对引用传递一定要注意。因为引用传递传的是尼玛指针。下面就是一个失败的例子。

```java
public class Person {
   public final Name name;
   public Person(Name name){
       this.name = name;
   }
   public Name getName(){
       return this.name;
   }
   public static void main(String[] agrs){
       Name n = new Name("Brady"，"Gao");
       Person p = new Person(n);
       System.out.println(p.getName().getFirstName());
       n.setFirstName("heihei");
       System.out.println(p.getName().getFirstName());
   }
}
class Name {
   private String firstName;
   private String lastName;
   public Name(){}
   public Name(String firstName，String lastName){
       this.firstName = firstName;
       this.lastName = lastName;
   }
   public String getFirstName(){
       return this.firstName;
   }
   public void setFirstName(String firstName){
       this.firstName = firstName;
   }
   public String getLastName(){
       return this.lastName;
   }
   public void setLastName(String lastName){
       this.lastName = lastName;
   }
}
```
要想解决这个，就要做到，避免引用传递带来的指针的直接传递。
重写 Person 的构造方法。

```java
public Person (Name name){
	this.name = new Name(name.getFirstName()，name.getLastName());
}
```

> Reference
> - 番茄博客-final 修饰符（原链接失效）
