---
title: CSS Font 整理总结
permalink: css-font-summary
date: 2016-06-23 19:30:00
tags: css
description:
---

&emsp;&emsp;对于web页面来说，字体就是计算机上存储的一套文字显示方式。通过对文字进行一些特殊处理（比如末端加强）来提高不同环境中文字的可读性。

<!-- more -->

## font-family
&emsp;&emsp;关于font-family的介绍大多数只是说明他可以设置文本中的字体名称序列。其实font-family真正的作用是将一系列近似的字体按照优先级顺序组成一个列表，浏览器从第一项开始依次查找，找到第一种可用的字体来显示文字。
``` css
font-family: Times New Roman,"open-sans","幼圆",sans-serif
```
&emsp;&emsp;当浏览器显示一个字符时，会首先从Times New Roman中寻找这个字符，如果找到就用Times New Roman字体来显示这个字符。如果没找到就去open-sans中寻找，如果找到就用该字体显示字符，没找到就会依次寻找下去，如果在通用字体库sans-serif中也没有找到就会用一个缺字符代替（通常是小方框）。
``` html
<p style='font-family: Times New Roman,"open-sans","幼圆",sans-serif'>
    <span>时间就是金钱</span><span>Time is money.</span>
</p>
```
![][1]
[1]: http://7xs09x.com1.z0.glb.clouddn.com/160623-css-font-summary-001.png
&emsp;&emsp;比如上面这段代码，对于汉字部分浏览器会先去Times New Roman中查找，没有找到，接着再去open-sans中查找，仍然没有找到，继续到“幼圆”中寻找，幼圆中可以找到对应字符则用该字体来显示。对于英文部分可以在Times New Roman中寻找则会用该字体来显示。

&emsp;&emsp;font-family中有时候字体加引号有时候不加引号。区别在于对字体名称中空格的处理不同。不加引号时，忽略字体左右两端的空白字符，单词之间的空白字符被解释为一个空白字符。比如font-family:   Times   New   Roman   , sans-serif。被解释为font-family:Times New Roman,sans-serif。加引号时，需要保留引号内的所有空格。比如font-family:"Times    New Roman",sans-serif。浏览器会去寻找“Times   New Roman”这个字体。

## 通用字体族
&emsp;&emsp;w3c建议在定义字体是最后以一个类别结尾，例如sans-serif，来保证不同操作系统下网页都能够正确显示。常见的字体族为serif（衬线字体）、sans-serif（非衬线字体），可以简单理解为在所有字体都是失效的情况下，浏览器从字体族中选择一种字体来显示。
&emsp;&emsp;一种字体族代表了拥有某类特性的多种字体，字体族中字体的选择完全有浏览器决定。设计者给出的字体应该尽可能覆盖所有系统，而不应该依赖字体族。字体族一定要放到font-family的最后一位。

&emsp;&emsp;serif 衬线字体，通常是指使用末端加强原则的字体，通过在文字末端加入细小变化来改变小号文字的可读性。
![][2]
[2]: http://7xs09x.com1.z0.glb.clouddn.com/160623-css-font-summary-002.png
&emsp;&emsp;上述字体都是衬线字体，文字的末端使用了衬线。陈贤字体具有较高的可读性，通常用于以大段文字作为表现形式的作品如报纸、书籍等。常见的衬线字体有Georgia, Garamond, Times New Roman, 中文的宋体等等。

&emsp;&emsp;sans-serif非衬线字体，衬线字体以外的所有字体都成为非衬线字体。非衬线字体的线条比较均匀，通常在艺术字、标题中的使用较多。
![][3]
[3]: http://7xs09x.com1.z0.glb.clouddn.com/160623-css-font-summary-002.png
&emsp;&emsp;由于非衬线字体字条比较均匀，所以在小号文字下的可读性不如衬线字体。常见的非衬线字体有Trebuchet MS, Tahoma, Verdana, Arial, Helvetica, 中文的幼圆、隶书等等。

&emsp;&emsp;综上所述，**衬线字体适合小号文字的显示，如果使用非衬线字体要保证font-size足够大，以确保正文内容的可读性**。11px下的英文推荐使用衬线字体，对于中文，无论如何都不推荐11px下显示。

## @font-face
&emsp;&emsp;@font-face是链接服务器上的字体的一种方式，就像制定图片链接一样，浏览器会根据这条指令把对应字体下载到本地缓存，用它去修饰文本。
``` css
font-face {
    font-family:<identifier>;
    src:<fontsrc> [,<fontsrc>]*;
    <font>;
}
<fontsrc> = <url> [fontmat(<string>)]
```
`<identifier>`：字体名称
`<url>`：此值指的是你自定义的字体的存放路径，可以是相对路径也可以是绝路径
`<string>`：此值指的是你自定义的字体的格式，主要用来帮助浏览器识别，其值主要有以下几种类型：truetype, opentype,Web Open Font Format， embedded-opentype, svg等
`<font>`：定义字体相关样式,符合该样式设定的文本会使用该字体显示

&emsp;&emsp;truetype(.ttf)、opentype(.otf)这两种格式在绝大多数浏览器上都能正常工作。Web Open Font Format(.woff)是Web字体中最佳格式，他是一个开放的TrueType/OpenType的压缩版本，同时也支持元数据包的分离。Embedded Open Type(.eot)为IE的私有字体格式。svg(.svg)字体是基于SVG字体渲染的一种格式。下表中列出了这些格式的浏览器兼容性。
![][6]
[6]: http://7xs09x.com1.z0.glb.clouddn.com/160623-css-font-summary-table01.png

#### @font-face example
```css
font-face{
    font-family: 'open-sans';
    src: url('./open-sans/OpenSans-Regular.eot'); /* IE9+ */
    src: url('./open-sans/OpenSans-Regular.eot?#iefix') format('embedded-opentype'), /* IE6-IE8 */
         url('./open-sans/OpenSans-Regular.woff') format('woff'), /* chrome、firefox */
         url('./open-sans/OpenSans-Regular.ttf') format('truetype'), /* chrome、firefox、opera、Safari, Android, iOS 4.2+*/
         url('./open-sans/OpenSans-Regular.svg#fontname') format('svg'); /* iOS 4.1- */
    font-style: normal;
    font-weight: normal;
}
@font-face{
    font-family: 'open-sans';
    src: url('./open-sans/OpenSans-Bold.eot'); /* IE9+ */
    src: url('./open-sans/OpenSans-Bold.eot?#iefix') format('embedded-opentype'), /* IE6-IE8 */
         url('./open-sans/OpenSans-Bold.woff') format('woff'), /* chrome、firefox */
         url('./open-sans/OpenSans-Bold.ttf') format('truetype'), /* chrome、firefox、opera、Safari, Android, iOS 4.2+*/
         url('./open-sans/OpenSans-Bold.svg#fontname') format('svg'); /* iOS 4.1- */
    font-weight:bold;
}
```

```
<p style='font-family: open-sans,sans-serif'>
    <span>时间就是金钱</span><span>Time is money.</span>
</p>
<p style='font-family: open-sans,sans-serif;font-weight:bold;'>
    <span>时间就是金钱</span><span>Time is money.</span>
</p>
```
![][4]
[4]: http://7xs09x.com1.z0.glb.clouddn.com/160623-css-font-summary-004.png
&emsp;&emsp;上述代码中两次@font-face命令定义了一个字体族，在普通情况下使用OpenSans-Regular字体，粗体时使用OpenSans-Bold字体。这也印证了我们上文所说，对于字体族中的字体由浏览器根据当前设置自动选择。

&emsp;&emsp;如果要使用@font-face通常需要做一些优化工作，比如有的字体库太大就需要只保留网页中用到的文字，对于中文字体更是如此，这时候[字蛛(FontSpider)](http://font-spider.org/)工具可以来帮助我们；对于进一步优化，可以将字体文件以base64编码方式嵌入到css文件中来减少一次http请求，小米主页就是采用这种方式（[这里](http://www.mi.com/minote/)和[这里](http://www.mi.com/css/webfont/product-minote-overall.min.css)）。

![][5]
[5]: http://7xs09x.com1.z0.glb.clouddn.com/160623-css-font-summary-005.png

&emsp;&emsp;对于字体库的压缩可以使用这款[工具](https://www.fontsquirrel.com/tools/webfont-generator)。


> 参考转自 [我的小树林-CSS Font知识整理总结](http://www.cnblogs.com/dojo-lzz/p/4375347.html)
