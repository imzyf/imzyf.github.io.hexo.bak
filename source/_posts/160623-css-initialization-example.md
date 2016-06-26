---
title: CSS初始化示例
permalink: css-initialization-examples
comments: true
date: 2016-06-23 19:09:00
tags: css
description: CSS初始化是指重置你的浏览器风格样式。不同的浏览器默认样式可能是不一样的，所以开发的第一件事情是如何统一它们。如果不是因为CSS初始化经常出现浏览器之间的差异页面，那么在每次按属性初始化CSS样式一个新的站点或新开发的网页时，我们将使用CSS或HTML标签更方便和准确，所以我们开发的网页内容更方便、简洁、同时减少CSS代码量，节省网页加载时间。
---

>转自 [Programering-CSS initialization code](http://www.programering.com/a/MzN5gzMwATk.html)

CSS初始化是指重置你的浏览器风格样式。不同的浏览器默认样式可能是不一样的，所以开发的第一件事情是如何统一它们。如果不是因为CSS初始化经常出现浏览器之间的差异页面，那么在每次按属性初始化CSS样式一个新的站点或新开发的网页时，我们将使用CSS或HTML标签更方便和准确，所以我们开发的网页内容更方便、简洁、同时减少CSS代码量，节省网页加载时间。

CSS initialization refers to reset your browser style. Different browsers default style may not be the same, so the first thing development may be how to unify them. If not for the CSS initialization often appear page difference between browsers. Every time a new site or new development Webpage time by property initialization CSS style, we will use the CSS or HTML tag is more convenient and accurate, so we developed Webpage content is more convenient and concise, while reducing the amount of CSS code, save Webpage download time.

The most expensive, the most simple
```css
* { padding: 0; margin: 0; border: 0; } 
```

Selective initialization for example (comprehensive)
```css
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,legend,button
form,fieldset,input,textarea,p,blockquote,th,td {
　　padding: 0;
　　margin: 0;
}
/* Modified as appropriate */
body {
    background:#fff;color:#333;font-size:12px; margin-top:5px;font-family:"SimSun","Times New Roman","Arial Narrow";
}

/* A short reference values: 'or"" */
q:before,q:after {content:""}

/* Abbreviations, pictures without borders */
fieldset,img,abbr,acronym {border: 0 none;}
abbr,acronym {font-variant: normal;}
legend {color:#000;}

/* Remove special marking the font and font size */
address,caption,cite,code,dfn,em,strong,th,var {
　　font-weight: normal;
　　font-style: normal;
}

/* Superscript and subscript */
sup {vertical-align: text-top;}
sub {vertical-align: text-bottom;}

/* The frame table were combined into a single frame, specify the separation between the cell border boundary in the model of distance is 0*/
table {
　　border-collapse: collapse;
　　border-spacing: 0;
}

/* The table header and content of the left shows */
caption,th {text-align: left;}
input,img,select {vertical-align:middle;}

/* Clear list style */
ol,ul {list-style: none;}

/* The input control fonts */
input,button,textarea,select,optgroup,option {
    font-family:inherit;
    font-size:inherit;
    font-style:inherit;
    font-weight:inherit;
}

/* The caption element style clearance */ 
h1,h2,h3,h4,h5,h6 {
　　font-weight: normal;
　　font-size: 100%;
}

/* Link style, color can be modified as appropriate */
del,ins,a {text-decoration:none;}
a:link {color:#009;}
a:visited {color:#800080;}
a:hover,a:active,a:focus {color:#c00; text-decoration:underline;} 

/* Mouse style */
input[type="submit"] {cursor: pointer;}
button {cursor: pointer;}
input::-moz-focus-inner { border: 0; padding: 0;}

.clear {clear:both;}
```

Tencent QQ. com style initialization
```css
body,ol,ul,h1,h2,h3,h4,h5,h6,p,th,td,dl,dd,form,fieldset,legend,input,textarea,select{margin:0;padding:0}
body{font:12px"Times New Roman","Arial Narrow",HELVETICA;background:#fff;-webkit-text-size-adjust:100%;}
a{color:#2d374b;text-decoration:none}
a:hover{color:#cd0200;text-decoration:underline}
em{font-style:normal}
li{list-style:none}
img{border:0;vertical-align:middle}
table{border-collapse:collapse;border-spacing:0}
p{word-wrap:break-word}
```

Sina website style initialization
```css
body,ul,ol,li,p,h1,h2,h3,h4,h5,h6,form,fieldset,table,td,img,div{margin:0;padding:0;border:0;}
body{background:#fff;color:#333;font-size:12px; margin-top:5px;font-family:"SimSun","Times New Roman","Arial Narrow";}
ul,ol{list-style-type:none;}
select,input,img,select{vertical-align:middle;}
a{text-decoration:none;}
a:link{color:#009;}
a:visited{color:#800080;}
a:hover,a:active,a:focus{color:#c00;text-decoration:underline;}
```

Taobao website initialization style
```css
body, h1, h2, h3, h4, h5, h6, hr, p, blockquote, dl, dt, dd, ul, ol, li, pre, form, fieldset, legend, button, input, textarea, th, td 
{ margin:0; padding:0; }
body, button, input, select, textarea { font:12px/1.5tahoma, arial, \5b8b\4f53; }
h1, h2, h3, h4, h5, h6{ font-size:100%; }
address, cite, dfn, em, var { font-style:normal; }
code, kbd, pre, samp { font-family:couriernew, courier, monospace; }
small{ font-size:12px; }
ul, ol { list-style:none; }
a { text-decoration:none; }
a:hover { text-decoration:underline; }
sup { vertical-align:text-top; }
sub{ vertical-align:text-bottom; }
legend { color:#000; }
fieldset, img { border:0; }
button, input, select, textarea { font-size:100%; }
table { border-collapse:collapse; border-spacing:0; }
NetEase website (initialization) style
html {overflow-y:scroll;}
body {margin:0; padding:29px00; font:12px"\5B8B\4F53",sans-serif;background:#ffffff;}
div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,form,fieldset,input,textarea,blockquote,p{padding:0; margin:0;}
table,td,tr,th{font-size:12px;}
li{list-style-type:none;}
img{vertical-align:top;border:0;}
ol,ul {list-style:none;}
h1,h2,h3,h4,h5,h6{font-size:12px; font-weight:normal;}
address,cite,code,em,th {font-weight:normal; font-style:normal;}
```

Yahoo! Style initialization

``` css
html{background:none repeat scroll 0 0 #FFFFFF;color:#000000;}
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,textarea,p,blockquote,th,td{margin:0;padding:0;}
table{border-collapse:collapse;border-spacing:0;}
fieldset,img{border:0 none;}
address,caption,cite,code,dfn,em,strong,th,var{font-style:normal;font-weight:normal;}
li{list-style:none outside none;}
caption,th{text-align:left;}
h1,h2,h3,h4,h5,h6{font-size:100%;font-weight:normal;}
q:before,q:after{content:"";}
abbr,acronym{border:0 none;font-variant:normal;}
sup{vertical-align:text-top;}
sub{vertical-align:text-bottom;}
input,textarea,select{font-family:inherit;font-size:inherit;font-weight:inherit;}
input,textarea,select{}
legend{color:#000000;}
body{font:13px/1.231 arial,helvetica,clean,sans-serif;}
select,input,button,textarea{font:99% arial,helvetica,clean,sans-serif;}
table{font-size:inherit;}
pre,code,kbd,samp,tt{font-family:monospace;line-height:100%;}
a{text-decoration:none;}
a:hover,a:focus{text-decoration:underline;}
strong{font-weight:bold;}
input[type="submit"]{cursor:pointer;}
button{cursor:pointer;}
```

WEB developer
```
 /* css reset www.admin10000.com */
 body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,button,textarea,p,blockquote,th,td {margin:0;padding:0;}
body {background:#fff;color:#555;font-size:14px;font-family:Verdana,Arial,Helvetica,sans-serif;}
td,th,caption {font-size:14px;}
h1,h2,h3,h4,h5,h6 {font-weight:normal;font-size:100%;}
address,caption,cite,code,dfn,em,strong,th,var {font-style:normal;font-weight:normal;}
a {color:#555;text-decoration:none;}
a:hover {text-decoration:underline;}
img {border:none;}
ol,ul,li {list-style:none;}
input,textarea,select,button {font:14px Verdana,Helvetica,Arial,sans-serif;}
table {border-collapse:collapse;}
html {overflow-y:scroll;}
/* css common */
.clearfix:after {content:".";display:block;height:0;clear:both;visibility:hidden;}
.clearfix {*zoom:1;}

```

Blog Park
```
/*version:2.7.0*/
html,body {color:#000;background:#FFF;}
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,button,textarea,p,blockquote,th,td {margin:0;padding:0;}
table {border-collapse:collapse;border-spacing:0;}
fieldset,img {border:0;}
address,caption,cite,code,dfn,em,strong,th,var,optgroup {font-style:inherit;font-weight:inherit;}
del,ins {text-decoration:none;}
li {list-style:none;}
caption,th {text-align:left;}
h1,h2,h3,h4,h5,h6 {font-size:100%;font-weight:normal;}
q:before,q:after {content:'';}
abbr,acronym {border:0;font-variant:normal;}
sup {vertical-align:baseline;}
sub {vertical-align:baseline;}
legend {color:#000;}
input,button,textarea,select,optgroup,option {font-family:inherit;font-size:inherit;font-style:inherit;font-weight:inherit;}
input,button,textarea,select {*font-size:100%;}
.clear {clear:both;}
input::-moz-focus-inner {border:0;padding:0;}
/*added*/
input[type=button],input[type=submit] {-webkit-appearance:button;}
```

