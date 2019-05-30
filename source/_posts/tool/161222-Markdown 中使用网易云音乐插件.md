---
title: Markdown 中使用网易云音乐插件
permalink: 163-music-in-markdown
date: 2016-12-22 20:00:00
comments: true
toc: false
tags:
   - markdown
description:
---

一直大爱网易云音乐，也想着在 markdown 中插入音乐播放组件。研究了下，发现实现很容易。

## 选歌、生成代码

Step 1：打开 [网易云音乐网页版](http://music.163.com/) ，检索歌曲打开播放页面，例如 [G.E.M. - 偶尔](http://music.163.com/#/song?id=27836172) `http://music.163.com/#/song?id=27836172`

<!-- more -->

Step 2：在页面左侧点击 [生成外链播放器](http://music.163.com/#/outchain/2/27836172/)，有两种类型的插件：iframe、flash

## iframe 插件

```html
<iframe
  frameborder="no"
  border="0"
  marginwidth="0"
  marginheight="0"
  width="330"
  height="86"
  src="//music.163.com/outchain/player?type=2&id=27836172&auto=0&height=66"
></iframe>

<iframe
  frameborder="no"
  border="0"
  marginwidth="0"
  marginheight="0"
  width="298"
  height="52"
  src="//music.163.com/outchain/player?type=2&id=27836172&auto=0&height=32"
></iframe>
```

### iframe 插件效果

<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=86 src="//music.163.com/outchain/player?type=2&id=27836172&auto=0&height=66"></iframe>

<br />

<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width="298" height="52" src="//music.163.com/outchain/player?type=2&id=27836172&auto=0&height=32"></iframe>

## flash 插件

```html
<embed src="//music.163.com/style/swf/widget.swf?sid=27836172&type=2&auto=0&width=320&height=66" width="340" height="86"  allowNetworking="all"></embed>
```

### flash 插件效果

<embed src="//music.163.com/style/swf/widget.swf?sid=27836172&type=2&auto=0&width=320&height=66" width="340" height="86"  allowNetworking="all"></embed>
