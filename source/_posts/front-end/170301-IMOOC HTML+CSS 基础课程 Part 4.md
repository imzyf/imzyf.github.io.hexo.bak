---
title: IMOOC HTML+CSS 基础课程 Part 4
permalink: imooc-html-css-basic-course-part4
date: 2017-03-01 00:00:00
updated: 2017-03-12 10:00:00
comments: true
toc: true
tags:
   - html
   - css
description:
---

慕课网上【HTML+CSS 基础课程】学习笔记。本文主要内容：CSS 代码缩写、单位和值、样式设置小技巧。

<!-- more -->

## 第13章 CSS 代码缩写，占用更少的带宽
### 盒模型代码简写

还记得在讲盒模型时外边距（margin）、内边距（padding）和边框（border)设置上下左右四个方向的边距是按照顺时针方向设置的：上右下左
```
margin:10px 15px 12px 14px;/*上设置为10px、右设置为15px、下设置为12px、左设置为14px*/

margin:10px 10px 10px 10px;
// 可缩写为：
margin:10px;

margin:10px 20px 10px 20px;
// 可缩写为：
margin:10px 20px;

// 如果left和right的值相同，如下面代码：
margin:10px 20px 30px 20px;
// 可缩写为：
margin:10px 20px 30px;

// padding、border的缩写方法和margin是一致的。
```

### 颜色值缩写
当设置的颜色是16进制的色彩值时，如果每两位的值相同，可以缩写一半

```
p{color:#000000;}
// 可以缩写为：
p{color: #000;}

p{color: #336699;}
// 可以缩写为：
p{color: #369;}
```

### 字体缩写
```
body{
    font-style:italic;
    font-variant:small-caps;
    font-weight:bold;
    font-size:12px;
    line-height:1.5em;
    font-family:"宋体",sans-serif;
}

// 这么多行的代码其实可以缩写为一句：

body{
    font:italic small-caps bold 12px/1.5em "宋体",sans-serif;
}
```

注意：
- 使用这一简写方式你至少要指定 `font-size` 和 `font-family` 属性，其他的属性（如 font-weight、font-style、font-variant、line-height）如未指定将自动使用默认值。
- 在缩写时 `font-size` 与 `line-height` 中间要加入 `/` 斜扛。
- 一般情况下因为对于中文网站，英文还是比较少的，所以下面缩写代码比较常用：

```
body{
    font:12px/1.5em  "宋体",sans-serif;
}
// 只是有字号、行间距、中文字体、英文字体设置
```

## 第14章 单位和值
### 颜色值

字体颜色（color）、背景颜色（background-color）、边框颜色（border）等：

```
// 英文命令颜色
p{color:red;}

// RGB颜色
p{color:rgb(133,45,200);}

// 每一项的值可以是 0~255 之间的整数，也可以是 0%~100% 的百分数。如：
p{color:rgb(20%,33%,25%);}

// 十六进制颜色。原理其实也是 RGB 设置，值由 0-255 变成了十六进制 00-ff
p{color:#00ffff;}
```

### 长度值
长度单位总结一下，目前比较常用到px（像素）、em、% 百分比，要注意其实这三种单位都是相对单位。

- 像素：像素为什么是相对单位呢？因为像素指的是显示器上的小点（CSS规范中假设“90像素=1英寸”）。实际情况是浏览器会使用显示器的实际像素值有关，在目前大多数的设计者都倾向于使用像素（px）作为单位
- em：就是本元素给定字体的 font-size 值，如果元素的 font-size 为 14px ，那么 1em = 14px；如果 font-size 为 18px，那么 1em = 18px。如下代码：

```
p{font-size:12px;text-indent:2em;}
// 上面代码就是可以实现段落首行缩进 24px（也就是两个字体大小的距离）
```

下面注意一个特殊情况：
但当给 font-size 设置单位为 em 时，此时计算的标准以 p 的父元素的 font-size 为基础。如下代码：
```
<p>以这个<span>例子</span>为例。</p>
// css:
p{font-size:14px}
span{font-size:0.8em;}
// 结果 span 中的字体“例子”字体大小就为 11.2px（14 * 0.8 = 11.2px）。
```

- 百分比

```
p{font-size:12px;line-height:130%}
```
设置行高（行间距）为字体的 `130%`（12 * 1.3 = 15.6px）

## 第15章 CSS 样式设置小技巧
### 水平居中 - 行内元素

如果被设置元素为文本、图片等行内元素时，水平居中是通过给父元素设置 `text-align:center` 来实现的

``` html
<body>
	<div class="txtCenter">我想要在父容器中水平居中显示。</div>
</body>
<style>
.txtCenter{
	text-align:center;
}
</style>
```

### 水平居中 - 定宽块状元素
当被设置元素为 `块状元素` 时用 `text-aligncenter` 就不起作用了，这时也分两种情况：`定宽块状元素` 和 `不定宽块状元素`。

满足 `定宽` 和 `块状` 两个条件的元素是可以通过设置 `左右margin` 值为 `auto` 来实现居中的。
```
<body>
	<div>我是定宽块状元素，哈哈，我要水平居中显示。</div>
</body>
<style>
div{
	border:1px solid red;/*为了显示居中效果明显为 div 设置了边框*/
	width:200px;/*定宽*/
	margin:20px auto;/* margin-left 与 margin-right 设置为 auto */
	// 注意：元素的“上下 margin” 是可以随意设置的
}
</style>
```

### 水平居中 - 不定宽块状元素方法（一）

不定宽度的块状元素有三种方法居中：
1. 加入 `table` 标签
2. 设置 `display: inline` 方法：与第一种类似，显示类型设为 行内元素，进行不定宽元素的属性设置
3. 设置 `position:relative` 和 `left:50%`：利用 相对定位 的方式，将元素向左偏移 50% ，即达到居中的目的

加入 `table` 标签是利用 `table` 标签的长度自适应性，即不定义其长度也不默认父元素 body 的长度（table 其长度根据其内文本长度决定），因此可以看做一个定宽度块元素，然后再利用定宽度块状居中的 margin 的方法，使其水平居中

第一步：为需要设置的居中的元素外面加入一个 table 标签 ( 包括 `<tbody>`、`<tr>`、`<td>` )

第二步：为这个 table 设置 `左右 margin 居中`（这个和定宽块状元素的方法一样）

```
<div>
	<table>
	<tbody>
		<tr>
			<td>
				<ul>
					<li>我是第一行文本</li>
					<li>我是第二行文本</li>
					<li>我是第三行文本</li>
				</ul>
			</td>
		</tr>
	</tbody>
	</table>
</div>
<style>
table{
	border:1px solid;
	margin:0 auto;
}
</style>
```

### 水平居中 - 不定宽块状元素方法（二）

改变块级元素的 `display` 为 `inline` 类型（设置为 行内元素 显示），然后使用 `text-align:center` 来实现居中效果。

```
<body>
<div class="container">
    <ul>
        <li><a href="#">1</a></li>
        <li><a href="#">2</a></li>
        <li><a href="#">3</a></li>
    </ul>
</div>
</body>
<style>
.container{
    text-align:center;
}
/* margin:0;padding:0（消除文本与div边框之间的间隙）*/
.container ul{
    list-style:none;
    margin:0;
    padding:0;
    display:inline;
}
/* margin-right:8px（设置li文本之间的间隔）*/
.container li{
    margin-right:8px;
    display:inline;
}
</style>
```

这种方法相比第一种方法的优势是不用增加无语义标签，但也存在着一些问题：它将块状元素的 display 类型改为 inline，变成了**行内元素**，所以少了一些功能，比如设定长度值

### 水平居中 - 不定宽块状元素方法（三）

- 通过给父元素设置 `float`，然后给父元素设置 `position:relative` 和 `left:50%`，子元素设置 `position:relative` 和 `left: -50%` 来实现水平居中
- `div` 中间有条平分界线，然后将 `ul` 的最左端与 `div` 的平分线对其；
- `li` 中有条平分线，然后将 `li` 的平分线与 `ul` 的最左端对其；

简单的说就是：`div` 和 `li` 都有条平分线，然后 `ul` 的最左端作为平分线标准，`div` 和 `li` 都与其对其，然后 `div` 确定外框，则 `li` 就是在 `div` 的中间

注：可以使用 `clear:both;` 清除浮动

```
<body>
<div class="container">
	<ul>
		<li><a href="#">1</a></li>
		<li><a href="#">2</a></li>
		<li><a href="#">3</a></li>
	</ul>
</div>
</body>
<style>
.container{
	float:left;
	position:relative;
	left:50%
}
.container ul{
	list-style:none;
	margin:0;
	padding:0;

	position:relative;
	left:-50%;
}
.container li{float:left;display:inline;margin-right:8px;}
</style>
```

### 垂直居中 - 父元素高度确定的单行文本

分两种情况：父元素高度确定的单行文本，以及父元素高度确定的多行文本

父元素高度确定的单行文本的竖直居中的方法是通过设置父元素的 height 和 line-height 高度一致来实现的 （height: 该元素的高度，line-height: 顾名思义，行高（行间距），指在文本中，行与行之间的**基线间的距离** ）

`line-height` 与 `font-size` 的计算值之差，在 CSS 中成为“行间距”。分为两半，分别加到一个文本行内容的顶部和底部

这种文字行高与块高一致带来了一个弊端：当文字内容的长度大于块的宽时，就有内容脱离了块（溢出）
```
<div class="container">
    hi,imooc!
</div>
<style>
.container{
    height:100px;
    line-height:100px;
    background:#999;
}
</style>
```

### 垂直居中 - 父元素高度确定的多行文本（方法一）

使用插入 table  (包括tbody、tr、td)标签，同时设置 `vertical-align：middle`

CSS 中有一个用于竖直居中的属性 `vertical-align`，在父元素设置此样式时，会对 inline-block 类型的子元素都有用。下面看一下例子：

```
<table>
<tbody>
	<tr>
		<td class="wrap">
			<div>
			    <p>看我是否可以居中。</p>
			</div>
		</td>
	</tr>
</tbody>
</table>
<style>
	table td{height:500px;background:#ccc}
</style>
```

因为 td 标签默认情况下就默认设置了 `vertical-align: middle`，所以我们不需要显式地设置了

### 垂直居中 - 父元素高度确定的多行文本（方法二）
在 chrome、firefox 及 IE8 以上的浏览器下可以设置块级元素的 display 为 table-cell（设置为表格单元显示），激活 vertical-align 属性，但注意 IE6、7 并不支持这个样式，兼容性比较差

```
<div class="container">
    <div>
        <p>看我是否可以居中。</p>
        <p>看我是否可以居中。</p>
        <p>看我是否可以居中。</p>
    </div>
</div>
<style>
.container{
    height:300px;
    background:#ccc;
    display:table-cell;/*IE8以上及Chrome、Firefox*/
    vertical-align:middle;/*IE8以上及Chrome、Firefox*/
}
</style>
```
这种方法的好处是不用添加多余的无意义的标签，但缺点也很明显，它的兼容性不是很好，不兼容 IE6、7而且这样修改display的block变成了table-cell，破坏了原有的块状元素的性质（笔者：IE6、7 基本可以放弃了）

### 隐性改变 display 类型

有一个有趣的现象就是当为元素（不论之前是什么类型元素，display:none 除外）设置以下 2 个句之一：

1. `position : absolute`
2. `float : left` 或 `float:right`
只要 HTML 代码中出现以上两句之一，元素的 display 显示类型就会自动变为以 `display:inline-block`（块状元素）的方式显示，当然就可以设置元素的 width 和 height 了，且默认宽度不占满父元素

如下面的代码，`a` 标签是 行内元素 ，所以设置它的 width 是 没有效果的，但是设置为 `position:absolute` 以后，就可以了

```
<div class="container">
    <a href="#" title="">进入课程请单击这里</a>
</div>
<style>
.container a{
    position:absolute;
    width:200px;
    background:#ccc;
}
</style>
```
