---
title: IMOOC 如何用 CSS 进行网页布局
permalink: imooc-how-to-use-css-for-web-layout
date: 2017-03-12 12:00:00
comments: true
toc: true
tags: 
   - html
   - css
description: 
---
&emsp;&emsp;慕课网上【如何用 CSS 进行网页布局】学习笔记。一列布局、两列布局、三列布局、混合布局
<!-- more -->
## 一列布局
```
<style type="text/css">
body{marin:0;padding:0;}
.main{width:800px;height:300px;background:#ccc;margin:0 auto;}
.top{height:100px;background:blue;}
.foot{width:800px;height:300px;backround:red; maigin:0 auto;}
</style>
<div class="top"></div>
<div class="main"></div>
<div class="foot"></div>
```
## 两列布局
```
<style type="text/css">
.main{width:800px;margin: 0 auto;}
body{margin:0; padding:0; font-size:30px}
.left{width:20%;height:500px; float:left; background:#ccc;}
.right{width:80%;height:500px; float:right; background:#ddd;} 
</style>
<body>
	<div class="main">
		<div class="left"></div>
		<div class="right"></div>
	</div>
</body>
```
## 三列布局
&emsp;&emsp;中间自适应；注意 `position:absolute` 使用
```
<style type="text/css">
.left{ height:600px; width:200px; background:#ccc; position:absolute; left:0; top:0}
.main{ height:600px; margin:0 310px 0 210px; background:#9CF}
.right{ height:600px; width:300px; position:absolute; right:0; top:0;  background:#FCC;}
</style>

<div class="left">left</div>
<div class="main">设计首页的第一步是设计版面布局。</div>
<div class="right">right</div>
```
## 混合布局
```
<style>
body{ margin:0; padding:0; font-size:30px; font-weight:bold}
div{ text-align:center; line-height:50px}
.top{ height:100px;background:#9CF}
.head,.main{ width:960px; margin:0 auto;}
.head{ height:100px; background:#F90}
.left{ width:220px; height:600px; background:#ccc; float:left;}
.right{ width:740px; height:600px;background:#FCC; float:right}
.r_sub_left{ width:540px; height:600px; background:#9C3; float:left}
.r_sub_right{ width:200px; height:600px; background:#9FC; float:right;}
.footer{ height:50px; background:#9F9; clear:both;}
</style>

<div class="top">
    <div class="head">head</div>
</div>
<div class="main">
    <div class="left">left</div>
    <div class="right">
    	<div class="r_sub_left">sub_left
        </div>
        <div class=" r_sub_right">sub_right
        </div>
    </div>
</div>
<div class="footer">footer</div>
```
![混合布局](http://img.mukewang.com/58525eb80001417a12800720.jpg)

