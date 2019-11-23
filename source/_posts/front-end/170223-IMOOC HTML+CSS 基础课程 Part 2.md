---
title: IMOOC HTML+CSS 基础课程 Part 2
permalink: imooc-html-css-basic-course-part2
date: 2017-02-23 01:00:00
updated: 2019-11-25 17:56:14
tags:
  - html
  - css
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

慕课网上【 HTML+CSS 基础课程】学习笔记。本文主要内容：CSS 介绍，选择器，继承、层叠和特殊性，格式化排版。

<!-- more -->

## 第 6 章 开始学习 CSS，为网页添加样式

1. 认识 CSS 样式。CSS 全称为“层叠样式表 (Cascading Style Sheets)”，它主要是用于定义 HTML 内容在浏览器内的显示样式，如文字大小、颜色、字体加粗等
2. CSS 样式的优势。批量定义样式
3. CSS 代码语法。CSS 样式由 `选择符` 和 `声明` 组成，而 `声明` 又由 `属性` 和 `值` 组成
   - 选择符：又称选择器，指明网页中要应用样式规则的元素
   - 声明：在英文大括号 `{}` 中的的就是声明，属性和值之间用英文冒号 `:` 分隔。当有多条声明时，中间可以英文分号 `;` 分隔，如下所示：

```css
p {
  font-size: 12px;
  color: red;
}
```

- 最后一条声明可以没有分号，但是为了以后修改方便，一般也加上分号
- 为了使用样式更加容易阅读，可以将每条代码写在一个新行内

4、CSS 注释代码

用 `/*注释语句*/` 来标明（HTML 中使用 `<!--注释语句-->`）

## 第 7 章 CSS 样式基本知识

1、内联式 CSS 样式

内联式 CSS 样式表就是把 CSS 代码直接写在现有的 HTML 标签中

```html
<p style="color:red">这里文字是红色。</p>
```

2、嵌入式 CSS 样式

嵌入式 CSS 样式，就是可以把 CSS 样式代码写在 `<style type="text/css"></style>` 标签之间

```html
<style type="text/css">
  span {
    color: red;
  }
</style>
```

3、外部式 CSS 样式

外部式 CSS 样式（也可称为外联式）就是把 CSS 代码写一个单独的外部文件中，这个 CSS 样式文件以 `.css` 为扩展名，在 `<head>` 内（不是在 `<style>` 标签内）使用 `<link>` 标签将 CSS 样式文件链接到 HTML 文件内

```html
<link href="base.css" rel="stylesheet" type="text/css" />
```

- CSS 样式文件名称以有意义的英文字母命名，如 main.css
- `rel="stylesheet" type="text/css"` 是固定写法不可修改
- `<link>` 标签位置一般写在 `<head>` 标签之内

4、三种方法的优先级

内联式 > 嵌入式 > 外部式

但是嵌入式>外部式有一个前提：嵌入式 css 样式的位置一定在外部式的后面。其实总结来说，就是 **就近原则**（离被设置元素越近优先级别越高）

## 第 8 章 CSS 选择器

1、什么是选择器？

每一条 CSS 样式声明（定义）由两部分组成

```css
选择器 {
    样式;
}
```

2、标签选择器

标签选择器其实就是 HTML 代码中的标签。如右侧代码编辑器中的 `<html>`、`<body>`、`<h1>`、`<p>`

```css
p {
  font-size: 12px;
  line-height: 1.6em;
}
```

3、类选择器

```css
.类选器名称{css样式代码;}
```

4、ID 选择器

```css
#ID选择器名称{css样式代码;}
```

5、类和 ID 选择器的区别

相同点：可以应用于任何元素

不同点：

- ID 选择器只能在文档中使用一次
- 可以使用类选择器词列表方法为一个元素同时设置多个样式（不能使用 ID 词列表）

```html
<style>
  .stress {
    color: red;
  }
  .bigsize {
    font-size: 25px;
  }
</style>
<p>
  到了<span class="stress bigsize">三年级</span
  >下学期时，我们班上了一节公开课...
</p>
```

6、子选择器

子选择器 `>` 用于选择指定标签元素的第一代子元素

```css
.food > li {
  border: 1px solid red;
}
```

7、包含（后代）选择器

包含选择器 `空格` 用于选择指定标签元素下的后辈元素

```css
.first span {
  color: red;
}
```

总结：`>` 作用于元素的第一代后代，`空格` 作用于元素的所有后代。

8、通用选择器

通用选择器 `*` 作用是匹配 HTML 中所有标签元素

```css
* {
  color: red;
}
```

9、伪类选择符

伪类选择符，它允许给 HTML 不存在的标签（标签的某种状态）设置样式，比如说我们给 HTML 中一个标签元素的鼠标滑过的状态来设置字体颜色：

```css
a:hover {
  color: red;
}
```

10、分组选择符

HTML 多个标签元素设置同一个样式时，可以使用分组选择符 `,`

```css
h1,
span {
  color: red;
}
```

它相当于：

```css
h1 {
  color: red;
}
span {
  color: red;
}
```

## 第 9 章 CSS 继承、层叠和特殊性

1、继承

CSS 的**某些样式**是具有继承性的。继承是一种规则，它允许样式不仅应用于某个特定 HTML 标签元素，而且应用于其后代。

比如下面代码：如某种颜色应用于 `p` 标签，这个颜色设置不仅应用 `p` 标签，还应用于 `p` 标签中的所有子元素文本，这里子元素为 `span` 标签

```html
p{color:red;}
<p>三年级时，我还是一个<span>胆小如鼠</span>的小女孩。</p>
```

但注意有一些 CSS 样式是不具有继承性的，例如：

```html
p{border:1px solid red;}
<p>三年级时，我还是一个<span>胆小如鼠</span>的小女孩。</p>
```

在上面例子中它代码的作用只是给 `p` 标签设置了边框为 1 像素、红色、实心边框线，而对于子元素 `span` 是没用起到作用的

2、特殊性

有的时候我们为同一个元素设置了不同的 CSS 样式代码，那么元素会启用哪一个 CSS 样式

```html
p{color:red;} .first{color:green;}

<p class="first">三年级时，我还是一个<span>胆小如鼠</span>的小女孩。</p>
```

`p` 和 `.first` 都匹配到了 `p` 这个标签上，那么会显示哪种颜色呢？`green` 是正确的颜色。因为浏览器是根据权值来判断使用哪种 css 样式的，权值高的就使用哪种 css 样式。下面是权值的规则：

`标签` 的权值为 1，`类选择符` 的权值为 10，`ID选择符` 的权值最高为 100

```css
p {
  color: red;
} /*权值为1*/
p span {
  color: green;
} /*权值为1+1=2*/
.warning {
  color: white;
} /*权值为10*/
p span.warning {
  color: purple;
} /*权值为1+1+10=12*/
#footer .note p {
  color: yellow;
} /*权值为100+10+1=111*/
```

注意：还有一个权值比较特殊--继承也有权值但很低，有的文献提出它只有 0.1，所以可以理解为继承的权值最低

3、层叠

层叠就是在 html 文件中对于同一个元素可以有多个 CSS 样式存在，当有相同权重的样式存在时，会根据这些 CSS 样式的前后顺序来决定，处于最后面的 css 样式会被应用。

```html
p{color:red;} p{color:green;}
<p class="first">三年级时，我还是一个<span>胆小如鼠</span>的小女孩。</p>
```

最后 `p` 中的文本会设置为 green。所以 CSS 样式优先级：

**内联样式表（标签内部）> 嵌入样式表（当前文件中）> 外部样式表（外部文件中）**

4、重要性

使用 `!important` 为某些样式设置具有最高权值

```html
p{color:red!important;} p{color:green;}
<p class="first">三年级时，我还是一个<span>胆小如鼠</span>的小女孩。</p>
```

这时 `p` 段落中的文本会显示的 red

注意：`!important` 要写在分号的前面

当网页制作者不设置 CSS 样式时，浏览器会按照自己的一套样式来显示网页。并且用户也可以在浏览器中设置自己习惯的样式，比如有的用户习惯把字号设置为大一些，使其查看网页的文本更加清楚。这时注意样式优先级为：浏览器默认的样式 < 网页制作者样式 < 用户自己设置的样式，但记住 `!important` 优先级样式是个例外，权值高于用户自己设置的样式

## 第 10 章 CSS 格式化排版

1、字体

```css
body {
  font-family: "宋体";
}
```

这里注意不要设置不常用的字体，因为如果用户本地电脑上如果没有安装你设置的字体，就会显示浏览器默认的字体。（因为用户是否可以看到你设置的字体样式取决于用户本地电脑上是否安装你设置的字体。）

现在一般网页喜欢设置“微软雅黑”，如下代码：

```css
body {
  font-family: "Microsoft Yahei";
}
```

或

```css
body {
  font-family: "微软雅黑";
}
```

注意：第一种方法比第二种方法兼容性更好一些。使用微软雅黑，没有版权问题吗？）

2、字号、颜色

```css
body {
  font-size: 12px;
  color: #666;
}
```

3、粗体、斜体、下划线、删除线

```css
p span {
  font-weight: bold;
}
p a {
  font-style: italic;
}
p a {
  text-decoration: underline;
}
.oldPrice {
  text-decoration: line-through;
}
```

4、段落排版 - 缩进

```css
p {
  text-indent: 2em;
}
```

注意：2em 的意思就是文字的 2 倍大小

5、段落排版 - 行间距（行高）

```css
p {
  line-height: 1.5em;
}
```

6、段落排版 - 中文字间距、字母间距

```css
h1 {
  letter-spacing: 50px; // 中文字间隔、字母间隔设置
  word-spacing: 50px; // 单词间距设置
}
```

7、段落排版 - 对齐
&emsp;&emsp;为块状元素中的文本、图片设置居中/左/右

```css
h1 {
  text-align: center/left/right;
}
```
