---
title: PHP 中 this self parent 用法
permalink: how-to-use-this-self-parent-in-php
date: 2017-05-25 15:00:00
comments: true
toc: true
tags:
   - php
description:
---

## for member variable

- `$this` 调用非静态变量
- `self::` 调用静态变量

```php
<?php
class X {
    private $non_static_member = 1;
    private static $static_member = 2;

    function __construct() {
        echo $this->non_static_member . ' '
           . self::$static_member;
    }
}
new X();
?>
```

## for functions

- `self::` 调用的是本类方法；可以抑制方法多态性
- `parent::` 调用的是父类方法
- `$this` 调用本实例的方法；可以体现多态性；`$this` 调用静态方法语法上是完全可以的

polymorphism with `$this` for member functions:

```php
<?php
class X {
    function foo() {
        echo 'X::foo()';
    }
    function bar() {
        $this->foo();
    }
}
class Y extends X {
    function foo() {
        echo 'Y::foo()';
    }
}
$x = new Y();
$x->bar();
?>
```

```
Y::foo()
```

<!-- more -->

suppressing polymorphic behaviour by using `self::` for member:

```php
<?php
class X {
    function foo() {
        echo 'X::foo()';
    }

    function bar() {
        self::foo();
    }
}
class Y extends X {
    function foo() {
        echo 'Y::foo()';
    }
}
$x = new Y();
$x->bar();
?>
```

```
X::foo()
```

> Reference:
>
> - [php - When to use self over \$this? - Stack Overflow](https://stackoverflow.com/questions/151969/when-to-use-self-over-this)
