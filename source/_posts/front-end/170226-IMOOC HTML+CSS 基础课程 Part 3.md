---
title: IMOOC HTML+CSS 基础课程 Part 3
permalink: imooc-html-css-basic-course-part3
date: 2017-02-26 13:00:00
updatetime: 2017-03-01 00:00:00
comments: true
toc: true
tags:
   - html
   - css
description:
---

&emsp;&emsp;慕课网上【 HTML+CSS 基础课程】学习笔记。本文主要内容： CSS 盒模型、CSS 布局模型
<!-- more -->
## 第11章 CSS 盒模型
1、元素分类
&emsp;&emsp;HTML 中标签元素大体被分为三类：块状元素、内联元素（又叫行内元素）和内联块状元素
&emsp;&emsp;常用的块状元素有：
```
<div>、<p>、<h1>...<h6>、<ol>、<ul>、<dl>、<table>、<address>、<blockquote> 、<form>
```
&emsp;&emsp;常用的内联元素有：
```
<a>、<span>、<br>、<i>、<em>、<strong>、<label>、<q>、<var>、<cite>、<code>
```
&emsp;&emsp;常用的内联块状元素有：
```
<img>、<input>
```
2、块级元素
&emsp;&emsp;在 HTML 中 `<div>`、 `<p>`、`<h1>`、`<form>`、`<ul>` 和 `<li>` 就是块级元素
&emsp;&emsp;设置 `display:block` 就是将元素显示为块级元素。如下代码就是将内联元素 `a` 转换为块状元素：
```
a{display:block;}
```
&emsp;&emsp;块级元素特点：
&emsp;&emsp;- 每个块级元素都从新的一行开始，并且其后的元素也另起一行；
&emsp;&emsp;- 元素的高度、宽度、行高以及顶和底边距都可设置；
&emsp;&emsp;- 元素宽度在不设置的情况下，是它本身父容器的100%（和父元素的宽度一致），除非设定一个宽度；

3、内联元素
&emsp;&emsp;在 HTML 中，`<span>`、`<a>`、`<label>`、 `<strong>` 和 `<em>` 就是典型的内联元素（行内元素）（inline）元素。
&emsp;&emsp;当然块状元素也可以通过代码 `display:inline` 将元素设置为内联元素。如下代码就是将块状元素 `div` 转换为内联元素，从而使 `div` 元素具有内联元素特点
```
div{display:inline;}
```
&emsp;&emsp;内联元素特点：
&emsp;&emsp;- 和其他元素都在一行上；
&emsp;&emsp;- 元素的高度、宽度及顶部和底部边距不可设置；
&emsp;&emsp;- 元素的宽度就是它包含的文字或图片的宽度，不可改变；

4、内联块状元素
&emsp;&emsp;内联块状元素（inline-block）就是同时具备内联元素、块状元素的特点
&emsp;&emsp;`<img>`、`<input>` 标签就是这种内联块状标签
```
div{display:inline-block;}
```
&emsp;&emsp;inline-block 元素特点：
&emsp;&emsp;- 和其他元素都在一行上；
&emsp;&emsp;- 元素的高度、宽度、行高以及顶和底边距都可设置；

5、盒模型
&emsp;&emsp;内填充（padding）：页面元素与内容之间的距离
&emsp;&emsp;外边距（margin）：两个盒子模型之间的距离
&emsp;&emsp;边框（border）
&emsp;&emsp;内填充、外边距、边框都有4个方向（如内填充分为 padding-top/padding-bottom/padding-left/padding-right ）
&emsp;&emsp;注意：内部元素的实际高度是：内容高度+上下内填充高度+上下边框的高度，宽度同理

6、边框
&emsp;&emsp;边框可以设置它的粗细、样式和颜色
```
div{
    border:2px  solid  red;
}
```
&emsp;&emsp;上面是 border 代码的缩写形式，分开写：
```
div{
    border-width:2px;
    border-style:solid;
    border-color:red;
}
```
&emsp;&emsp;注意：
&emsp;&emsp;- border-style（边框样式）常见样式有：dashed（虚线）| dotted（点线）| solid（实线）
&emsp;&emsp;- border-color（边框颜色）中的颜色可设置为十六进制颜色，如：border-color:#888;
&emsp;&emsp;- border-width（边框宽度）中的宽度也可以设置为：thin | medium | thick，最常还是用象素（px）

&emsp;&emsp;单独设置某一边框
```
div{
	border-bottom:1px solid red;
	border-top:1px solid red;
	border-right:1px solid red;
	border-left:1px solid red;
}
```

7、宽度和高度
&emsp;&emsp;CSS 定义的宽（width）和高（height），指的是填充以里的内容范围
&emsp;&emsp;因此一个元素实际宽度（盒子的宽度）= 左边界 + 左边框 + 左填充 + 内容宽度 + 右填充 + 右边框 + 右边界
![一个元素实际宽度](https://img.mukewang.com/539fbb3a0001304305570259.jpg)
```
div{
    width:200px;
    padding:20px;
    border:1px solid red;
    margin:10px;
}
```
&emsp;&emsp;元素的实际长度为：10px + 1px + 20px + 200px + 20px + 1px + 10px = 262px
![元素的实际长度](https://img.mukewang.com/543b4cae0001b34304300350.jpg)

9、填充
&emsp;&emsp;元素内容与边框之间是可以设置距离的，称之为“填充”。填充也可分为上、右、下、左（顺时针）
```
div{padding:20px 10px 15px 30px;}
```
&emsp;&emsp;可以分开写上面代码：
```
div{
   padding-top:20px;
   padding-right:10px;
   padding-bottom:15px;
   padding-left:30px;
}
```
&emsp;&emsp;如果上、右、下、左的填充都为 10px; 可以这么写：
```
div{padding:10px;}
```
如果上下填充一样为 10px，左右一样为 20px，可以这么写：
```
div{padding:10px 20px;}
```

10、边界
&emsp;&emsp;元素与其它元素之间的距离可以使用边界（margin）来设置。边界也是可分为上、右、下、左
```
div{margin:20px 10px 15px 30px;}
```
&emsp;&emsp;其他同 `padding`

## 第12章 CSS 布局模型
1、CSS 布局模型
&emsp;&emsp;如果说布局模型是本，那么 CSS 布局模板就是末了，是外在的表现形式。CSS 包含3种基本的布局模型，用英文概括为：Flow、Layer 和 Float
&emsp;&emsp;- 流动模型（Flow）
&emsp;&emsp;- 浮动模型 (Float)
&emsp;&emsp;- 层模型（Layer）

2、流动模型
&emsp;&emsp;流动（Flow）是默认的网页布局模式
&emsp;&emsp;流动布局模型具有2个比较典型的特征：
&emsp;&emsp;- 第一点，块状元素都会在所处的包含元素内自上而下按顺序垂直延伸分布，因为在默认状态下，块状元素的宽度都为100%。实际上，块状元素都会以行的形式占据位置
```
<div id="box2">box2</div><!--块状元素，由于没有设置宽度，宽度默认显示为100%-->
<h1>标题</h1><!--块状元素，由于没有设置宽度，宽度默认显示为100%-->
<p>文本段文本段文本段文本段文本段文本段文本段文本段文本段文本段文本段文本段文本段文本段文本段文本段文本段。</p><!--块状元素，由于没有设置宽度，宽度默认显示为100%-->
<div id="box1">box1</div><!--块状元素，由于设置了width:300px，宽度显示为300px-->
```
&emsp;&emsp;第二点，在流动模型下，内联元素都会在所处的包含元素内从左到右水平分布显示
```
<a href="http://www.imooc.com">www.imooc.com</a><span>强调</span><em>重点</em>
<strong>强调</strong>
```

3、浮动模型
&emsp;&emsp;块状元素这么霸道都是独占一行，设置元素浮动可以实现让两个块状元素并排显示
&emsp;&emsp;任何元素在默认情况下是不能浮动的，但可以用 CSS 定义为浮动，如 div、p、table、img 等元素都可以被定义为浮动。如下代码可以实现两个 div 元素一行显示。
```
div{
    width:200px;
    height:200px;
    border:2px red solid;
    float:left;
}
<div id="div1"></div>
<div id="div2"></div>
```

4、层模型
&emsp;&emsp;层布局模型就像是图像软件PhotoShop中非常流行的图层编辑功能一样，每个图层能够精确定位操作。网页上局部使用层布局是有其方便之处的
&emsp;&emsp;CSS定义了一组定位（positioning）属性来支持层布局模型
&emsp;&emsp;- 绝对定位（position: absolute）
&emsp;&emsp;- 相对定位（position: relative）
&emsp;&emsp;- 固定定位（position: fixed）
&emsp;&emsp;如果想为元素设置层模型中的绝对定位，需要设置position:absolute(表示绝对定位)，这条语句的作用将元素从文档流中拖出来，然后使用left、right、top、bottom属性相对于其最接近的一个具有定位属性的父包含块进行绝对定位。如果不存在这样的包含块，则相对于body元素，即相对于浏览器窗口。

4、层模型 - 绝对定位
&emsp;&emsp;如果想为元素设置层模型中的绝对定位，需要设置 `position:absolute` （表示绝对定位），这条语句的作用将元素从文档流中拖出来，然后使用 left、right、top、bottom 属性相对于其**最接近的一个具有定位属性**的父包含块进行绝对定位。如果不存在这样的包含块，则相对于body元素，即相对于浏览器窗口
&emsp;&emsp;如下面代码可以实现 div 元素相对于浏览器窗口向右移动 100px，向下移动 50px
```
div{
	width:200px;
	height:200px;
	border:2px red solid;
	position:absolute;
	left:100px;
	top:50px;
}
<div id="div1"></div>
```
![层模型 - 绝对定位 | 400x0](https://img.mukewang.com/53a00b130001e86707360547.jpg)

5、层模型 - 相对定位
&emsp;&emsp;如果想为元素设置层模型中的相对定位，需要设置 `position:relative`（表示相对定位），它通过 left、right、top、bottom 属性确定元素在正常文档流中的偏移位置。相对定位完成的过程是首先按 static(float) 方式生成一个元素(并且元素像层一样浮动了起来)，然后相对于以前的位置移动，移动的方向和幅度由 left、right、top、bottom 属性确定，偏移前的位置保留不动
```
#div1{
    width:200px;
    height:200px;
    border:2px red solid;
    position:relative;
    left:100px;
    top:50px;
}
<div id="div1"></div>
```
<img src="https://img.mukewang.com/53a00d2b00015c4b06190509.jpg" height="350px" />
&emsp;&emsp;什么叫做“偏移前的位置保留不动”呢？
```
<body>
    <div id="div1"></div><span>偏移前的位置还保留不动，覆盖不了前面的div没有偏移前的位置</span>
</body>
```
<img src="https://img.mukewang.com/541a4bfc0001abef05940489.jpg" height="350px" />

6、层模型 - 固定定位
&emsp;&emsp;fixed：表示固定定位，与absolute定位类型类似，但它的相对移动的坐标是视图（屏幕内的网页窗口）本身。由于视图本身是固定的，它不会随浏览器窗口的滚动条滚动而变化，除非你在屏幕中移动浏览器窗口的屏幕位置，或改变浏览器窗口的显示大小，因此固定定位的元素会始终位于浏览器窗口内视图的某个位置，不会受文档流动影响，这与 `background-attachment:fixed;` 属性功能相同。
&emsp;&emsp;以下代码可以实现相对于浏览器视图向右移动100px，向下移动50px。并且拖动滚动条时位置固定不变
```
<style type="text/css">
#div1{
    width:200px;
    height:200px;
    border:2px red solid;
    position:fixed;
    left:100px;
    top:50px;
}
</style>
<p>文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本文本。</p>
...
```

7、Relative 与 Absolute 组合使用
&emsp;&emsp;使用 `position:absolute` 可以实现被设置元素相对于浏览器（body）设置定位以后，使用 `position:relative` 可以相对于其它元素进行定位
&emsp;&emsp;但是必须遵守下面规范：
&emsp;&emsp;- 参照定位的元素必须是相对定位元素的前辈元素：
```
<div id="box1"><!--参照定位的元素-->
    <div id="box2">相对参照元素进行定位</div><!--相对定位元素-->
</div>
```
&emsp;&emsp;- 参照定位的元素必须加入 `position:relative;`
```
#box1{
    width:200px;
    height:200px;
    position:relative;
}
```
&emsp;&emsp;- 定位元素加入 `position:absolute`，便可以使用top、bottom、left、right来进行偏移定位了
```
#box2{
    position:absolute;
    top:20px;
    left:30px;
}
```
&emsp;&emsp;这样box2就可以相对于父元素box1定位了（这里注意参照物就可以不是浏览器了，而可以自由设置了）
