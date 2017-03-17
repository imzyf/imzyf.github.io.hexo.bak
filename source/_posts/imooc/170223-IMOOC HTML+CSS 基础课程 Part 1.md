---
title: IMOOC HTML+CSS 基础课程 Part 1
permalink: imooc-html-css-basic-course-part1
date: 2017-02-23 00:00:00
comments: true
toc: true
tags: 
   - html
   - css
description: 
---

&emsp;&emsp;2017 年一个心愿，认真学习前端，成为公司里最厉害前端工程师。Flag 立的还是很大的……
&emsp;&emsp;本文主要内容：HTML 介绍，基本标签，表单标签
<!-- more -->

## 第1章 HTML 介绍
&emsp;&emsp;1、HTML 是网页内容的载体。内容就是网页制作者放在页面上想要让用户浏览的信息，可以包含文字、图片、视频等。
&emsp;&emsp;2、CSS 样式是表现。就像网页的外衣。比如，标题字体、颜色变化，或为标题加入背景图片、边框等。所有这些用来改变内容外观的东西称之为表现。
&emsp;&emsp;3、 JavaScript 是用来实现网页上的特效效果。如：鼠标滑过弹出下拉菜单。或鼠标滑过表格的背景颜色改变。还有焦点新闻（新闻图片）的轮换。可以这么理解，有动画的，有交互的一般都是用 JavaScript 来实现的。

## 第2章 认识标签(第一部分)
&emsp;&emsp; 常常会听到一个词，**语义化**。说的通俗点就是：明白每个标签的用途（在什么情况下使用此标签合理）。
&emsp;&emsp; 比如，网页上的文章的标题就可以用标题标签，网页上的各个栏目的栏目名称也可以使用标题标签。文章中内容的段落就得放在段落标签中，在文章中有想强调的文本，就可以使用 `em` 标签表示强调等等。
&emsp;&emsp; 语义化可以给我们带来什么样的好处呢？
&emsp;&emsp; - 更容易被搜索引擎收录。
&emsp;&emsp; - 更容易让屏幕阅读器读出网页内容。

1、在网页上要展示出来的页面内容一定要放在 `body` 标签中；
2、如果想在网页上显示文章，这时就需要 `<p>` 标签了，把文章的段落放到 `<p>` 标签；
```
<p>段落文本</p>
```
3、标题标签一共有6个，h1、h2、h3、h4、h5、h6分别为一级标题、二级标题、三级标题、四级标题、五级标题、六级标题。并且依据重要性递减。`<h1>` 是最高的等级
```
<hx>标题文本</hx>(x为1-6)
```
4、在一段话中特别强调某几个文字，这时候就可以用到 `<em>` 或 `<strong>` 标签。在浏览器中 `<em>` 默认用斜体表示，`<strong>` 用粗体表示。两个标签相比，目前国内前端程序员更喜欢使用 `<strong>` 表示强调
```
<em>需要强调的文本</em>
```
<em>需要强调的文本</em>
```
<strong>需要强调的文本</strong>
```
<strong>需要强调的文本</strong>
5、<span>标签是没有语义的，它的作用就是为了设置单独的样式用的
```
<span>文本</span>
```
6、想引用某个作家的一句诗，这样会使你的文章更加出彩，那么 `<q>` 标签是你所需要的
```
<q>引用文本</q>
```
<q>引用文本</q>
7、`<blockquote>` 的作用也是引用别人的文本。但它是对长文本的引用，如在文章中引入大段某知名作家的文字，这时需要这个标签。
```
<blockquote>引用文本</blockquote>
```
<blockquote>引用文本</blockquote>
8、使用 `<br>` 标签分行显示文本
&emsp;&emsp;xhtml1.0写法：`<br />`
&emsp;&emsp;html4.01写法：`<br>`
&emsp;&emsp;**注意：现在一般使用 xhtml1.0 的版本的写法（其它标签也是），这种版本比较规范**
9、为你的网页中添加一些空格
&emsp;&emsp;`&nbsp;`
10、`<hr>` 添加水平横线
&emsp;&emsp;html4.01版本：`<hr>`
&emsp;&emsp;xhtml1.0版本：`<hr />`
&emsp;&emsp;`<hr />` 标签的在浏览器中的默认样式线条比较粗，颜色为灰色，可能有些人觉得这种样式不美观，没有关系，这些外在样式在我们以后学习了 css 样式表之后，都可以对其修改
11、联系地址信息如公司的地址就可以 `<address>` 标签。也可以定义一个地址（比如电子邮件地址）、签名或者文档的作者身份
```
<address>联系地址信息</address>
```
<address>联系地址信息</address>
12、网页中显示一些计算机专业的编程代码，当代码为一行代码时，你就可以使用 `<code>` 标签
```
<code>var i=i+300;</code>
```
<code>var i=i+300;</code>
13、如果是多行代码，可以使用 `<pre>` 标签
```
<pre>语言代码段</pre>
```
&emsp;&emsp;`<pre>` 标签的主要作用：预格式化的文本。被包围在 `</pre>` 元素中的文本通常会保留空格和换行符
&emsp;&emsp;注意：`<pre>` 标签不只是为显示计算机的源代码时用的，在你需要在网页中预显示格式时都可以使用它，只是 `<pre>` 标签的一个常见应用就是用来展示计算机的源代码


## 第3章 认识标签(第二部分)
1、使用 `ul`，添加列表
```
<ul>
  <li>信息</li>
  <li>信息</li>
   ......
</ul>
```
2、使用 `ol`，添加有前后顺序的列表
```
<ol>
   <li>信息</li>
   <li>信息</li>
   ......
</ol>
```
3、把一些独立的逻辑部分划分出来，放在一个 `<div>` 标签中，这个 `<div>` 标签的作用就相当于一个容器
```
<div>…</div>
```
4、给 `div` 命名，使逻辑更加清晰。可以为这一个独立的逻辑部分设置一个名称，用 `id` 属性来为 `<div>` 提供**唯一**的名称
```
<div id="版块名称">…</div>
```
5、`table` 标签，认识网页上的表格
&emsp;&emsp;`<table>…</table>`：整个表格以 `<table>` 标记开始、`</table>` 标记结束
&emsp;&emsp;`<tbody>…</tbody>`：当表格内容非常多时，表格会下载一点显示一点，但如果加上 `<tbody>` 标签后，这个表格就要等表格内容全部下载完才会显示
&emsp;&emsp;`<tr>…</tr>`：表格的一**行**，所以有几对 `tr` 表格就有几行。
&emsp;&emsp;`<td>…</td>`：表格的一个单元格，一行中包含几对 `<td>...</td>`，说明一行中就有几**列**
&emsp;&emsp;`<th>…</th>`：表格的头部的一个单元格，表格**表头**
6、`caption` 标签，为表格添加标题和摘要
&emsp;&emsp;摘要：摘要的内容是不会在浏览器中显示出来的。它的作用是增加表格的可读性（语义化），使搜索引擎更好的读懂表格内容，还可以使屏幕阅读器更好的帮助特殊用户读取表格内容
```
<table summary="表格简介文本">
```
&emsp;&emsp;标题：用以描述表格内容，标题的显示位置：表格上方
```
<table>
	<caption>标题文本</caption>
    <tr>
        <td>…</td>
        <td>…</td>
        …
    </tr>
…
</table>
```
## 第4章 认识标签(第三部分)
1、使用 `<a>` 标签可实现超链接
```
<a href="目标网址" title="鼠标滑过显示的文本">链接显示的文本</a>
```
&emsp;&emsp;`title` 属性的作用，鼠标滑过链接文字时会显示这个属性的文本内容。这个属性在实际网页开发中作用很大，主要方便搜索引擎了解链接地址的内容（语义化更友好）
2、在新建浏览器窗口中打开链接
```
<a href="目标网址" target="_blank">click here!</a>
```
3、使用 `mailto` 在网页中链接 `Email` 地址
```
<a href="mailto:yy@imooc.com?subject=主题名称&body=邮件内容&cc=yy@mail.com">
```
4、`<img>` 为网页插入图片
```
<img src="图片地址" alt="下载失败时的替换文本" title = "提示文本" />
```

## 第5章 与浏览者交互，表单标签
1、`form` 标签与用户交互
&emsp;&emsp;表单是可以把浏览者输入的数据传送到服务器端，这样服务器端程序就可以处理表单传过来的数据
&emsp;&emsp;action：浏览者输入的数据被传送到的地方,比如一个PHP页面(save.php)
&emsp;&emsp;method： 数据传送的方式（get/post）
```
<form method="post/get" action="save.php">
	<label for="username">用户名:</label>
	<input type="text" name="username" />
	<label for="pass">密码:</label>
	<input type="password" name="pass" />
</form>
```
2、文本输入框、密码输入框
&emsp;&emsp;type：当 `type="text"` 时，输入框为文本输入框；当 `type="password"` 时, 输入框为密码输入框
&emsp;&emsp;name：为文本框命名，以备后台程序使用
&emsp;&emsp;value：为文本输入框设置默认值（一般起到提示作用）
```
<input type="text/password" name="名称" value="文本" />
```
3、文本域，支持多行文本输入
```
<textarea  rows="行数" cols="列数">文本</textarea>
```
&emsp;&emsp;注意：这两个属性可用css样式的width和height来代替：col用width、row用height来代替
4、使用单选框、复选框，让用户选择
&emsp;&emsp;type：当 type="radio" 时，控件为单选框；当 type="checkbox" 时，控件为复选框
&emsp;&emsp;注意：同一组的单选按钮，name 取值一定要一致，比如上面例子为同一个名称“radioLove”，这样同一组的单选按钮才可以起到单选的作用
```
<input type="radio/checkbox" value="值" name="名称" checked="checked"/>
```
5、使用下拉列表框，节省空间
&emsp;&emsp;设置 `selected="selected"` 属性，则该选项就被默认选中
```
<select>
	<option value="看书">看书</option>
	<option value="旅游" selected="selected">旅游</option>
	<option value="运动">运动</option>
	<option value="购物">购物</option>
</select>
```
6、使用提交按钮，提交数据
```
<input type="submit" value="提交" />
```
7、使用重置按钮，重置表单信息
```
<input type="reset" value="重置" />
```
8、form 表单中的 `label` 标签
&emsp;&emsp;`label` 标签不会向用户呈现任何特殊效果，它的作用是为鼠标用户改进了可用性。如果你在 `label` 标签内点击文本，就会触发此控件。就是说，当用户单击选中该 `label` 标签时，浏览器就会自动将焦点转到和标签相关的表单控件上（就自动选中和该 `label` 标签相关连的表单控件上）
```
<label for="控件id名称">
```
&emsp;&emsp;注意：标签的 `for` 属性中的值应当与相关控件的 `id` 属性值一定要相同
```
<form>
	<label for="male">男</label>
	<input type="radio" name="gender" id="male" />
	<br />
	<label for="female">女</label>
	<input type="radio" name="gender" id="female" />
	<label for="email">输入你的邮箱地址</label>
	<input type="email" id="email" placeholder="Enter email">
</form>
```

> Reference:
> - [HTML+CSS基础课程-慕课网](http://www.imooc.com/learn/9)
