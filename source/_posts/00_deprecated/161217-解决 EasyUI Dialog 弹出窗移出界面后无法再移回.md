---
title: 解决 EasyUI Dialog 弹出窗移出界面后无法再移回
permalink: resolving-easyui-dialog-out-of-windows-can-not-be-moved-back
date: 2016-12-17 10:00:00
updated: 2019-08-08 17:26:00
comments: true
toc: true
tags:
categories:
description:
---

**2019-08-08 更新：** 内容价值低，不再维护。

<!-- more -->

---

当不小心将 `EasyUI` `Dialog` 头部移出页面后，将无法再次移动弹出框，便只好刷新页面。

解决方法如下：

```javascript
/**
 * add by cgh
 * 针对panel window dialog三个组件拖动时会超出父级元素的修正
 * 如果父级元素的overflow属性为hidden，则修复上下左右个方向
 * 如果父级元素的overflow属性为非hidden，则只修复上左两个方向
 * @param left
 * @param top
 * @returns
 */
var easyuiPanelOnMove = function(left, top) {
  if ($(this).panel("options").closed) return;
  var parentObj = $(this)
    .panel("panel")
    .parent();
  var width = $(this).panel("options").width;
  var height = $(this).panel("options").height;
  var right = left + width;
  var buttom = top + height;
  var parentWidth = parentObj.width();
  var parentHeight = parentObj.height();

  if (left < 1) {
    $(this).panel("move", {
      left: 1
    });
  }
  if (top < 1) {
    $(this).panel("move", {
      top: 1
    });
  }
  if (parentWidth < right) {
    $(this).panel("move", {
      left: parentWidth - width
    });
  }

  if (parentHeight < buttom) {
    $(this).panel("move", {
      top: parentHeight - height
    });
  }
};
$.fn.window.defaults.onMove = easyuiPanelOnMove;
//$.fn.panel.defaults.onMove = easyuiPanelOnMove;
$.fn.dialog.defaults.onMove = easyuiPanelOnMove;
```

> Reference:
>
> - [easyui dialog 移动出界面问题](http://www.iteye.com/topic/1134739)
