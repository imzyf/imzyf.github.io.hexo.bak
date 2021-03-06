---
title: Vue Code Snippet
permalink: vue-code-snippet
date: 2019-08-08 17:33:38
updated: 2020-04-24 17:15:56
tags:
  - vue
  - code-snippet
categories:
description:
comments: true
toc: true
cover_img: https://images.unsplash.com/photo-1569161031678-f49b4b9ca1c2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=640&q=80
feature_img:
---

<!-- more -->

## watch 对象的属性

```javascript
data: {
   a: 100,
   msg: {
      channel: "音乐",
      style: "活泼"
   }
},
watch: {
   a(newval, oldVal) {
      console.log("new: %s, old: %s", newval, oldVal);
   }
}
```

```javascript
watch: {
   msg: {
      handler(newValue, oldValue) {
         console.log(newValue)
      },
      // 深度监听
      deep: true
   }
}
```

监听对象内的某一具体属性，可以通过 `computed` 做中间层来实现：

```javascript
computed: {
   channel() {
      return this.msg.channel
   }
},
watch:{
   channel(newValue, oldValue) {
      console.log('new: %s, old: %s', newval, oldVal)
   }
}
```

## 判断 data 中的对象是否为空

1、利用 `jQuery` 的 `isEmptyObject`：

```javascript
$.isEmptyObject(data.list);
```

实现源码：

```javascript
isEmptyObject: function(obj) {
   var name;
   for (name in obj) {
      return false;
   }
   return true;
}
```

2、获取到对象中的属性名，存到一个数组中，通过判断数组的 `length` 来判断此对象是否为空：

```javascript
var arr = Object.getOwnPropertyNames(data);
alert(arr.length == 0); // true
```

ES6：

```javascript
var arr = Object.keys(data.list);
alert(arr.length == 0); // true
```

3、转化为 `json` 字符串，再判断该字符串是否为 `{}`：

```javascript
var b = JSON.stringify(data) == "{}";
alert(b); // true
```

## 关闭 webpack-dev-server 自动刷新

文件保存后页面刷新，刷的眼晕。

```js
devServer: {
  ...
  hot: false,
  inline: false,
  liveReload: false
}
```

注释掉 `plugins` 中的相关插件。

```js
plugins: [
   // new webpack.HotModuleReplacementPlugin()
],
```

> 必须有 webpack.HotModuleReplacementPlugin 才能完全启用 HMR。如果 webpack 或 webpack-dev-server 是通过 --hot 选项启动的，那么这个插件会被自动添加，所以你可能不需要把它添加到 webpack.config.js 中。

## nextTick

在 Vue 生命周期的 `created()` 钩子函数进行的 DOM 操作一定要放在 `Vue.nextTick()` 的回调函数中。

在数据变化后要执行的某个操作，而这个操作需要使用随数据改变而改变的 DOM 结构的时候，这个操作都应该放进 `Vue.nextTick()` 的回调函数中。

> Vue 异步执行 DOM 更新。只要观察到数据变化，Vue 将开启一个队列，并缓冲在同一事件循环中发生的所有数据改变。如果同一个 `watcher` 被多次触发，只会被推入到队列中一次。这种在缓冲时去除重复数据对于避免不必要的计算和 DOM 操作上非常重要。然后，在下一个的事件循环 "tick" 中，Vue 刷新队列并执行实际 (已去重的) 工作。Vue 在内部尝试对异步队列使用原生的 `Promise.then` 和 `MessageChannel`，如果执行环境不支持，会采用 `setTimeout(fn, 0)` 代替。

## 键盘监听事件

> [按键修饰符 | vue](https://cn.vuejs.org/v2/guide/events.html#%E6%8C%89%E9%94%AE%E4%BF%AE%E9%A5%B0%E7%AC%A6)

```html
<input type="text" @keyup.esc="KeyUpEsc" />
```

> [将原生事件绑定到组件 | vue](https://cn.vuejs.org/v2/guide/components-custom-events.html#%E5%B0%86%E5%8E%9F%E7%94%9F%E4%BA%8B%E4%BB%B6%E7%BB%91%E5%AE%9A%E5%88%B0%E7%BB%84%E4%BB%B6)

使用 element 组件库的 el-input 标签，绑定 delete 键：

```html
<el-input
  v-model="input"
  placeholder="请输入内容"
  @keyup.delete.native="KeyUpDelete"
></el-input>
```

为什么这次绑定事件多一个 `.native` 修饰符，这个可能是因为 element-ui 封装了个 div 在 input 标签外面，把原来的事件隐藏了，所以如果不加 `.native` 的话，按键不会生效。

上面两种实现效果是当 input 标签获取到 _焦点_ 的时候，才能监听到键盘，下面这种是全局监听 enter 键，是把监听事件绑定到 document 上（登录页面常用）：

```js
created: function() {
   var _this = this;
   document.onkeydown = function(e) {
      let key = window.event.keyCode;
      if (key == 13) {
            _this.submit();
      }
   };
},
```

## 键盘回车后页面被刷新

form 回车后执行查询方法，但是却重新刷新了页面，并且路由多了一个问号，`http://localhost:3009/?#/admin`。

解决方案：`el-from` 加上 `@submit.native.prevent`：

```html
<el-form @submit.native.prevent>
  <el-form-item>
    <el-input @keyup.enter.native="handleInputConfirm(obj)"> </el-input>
  </el-form-item>
</el-form>

<script>
  export default {
    methods: {
      handleInputConfirm(obj) {
        // ... 提交内容
      },
    },
  };
</script>
```

原因：当一个 `form` 元素中只有一个输入框时，在该输入框中按下回车应提交该表单。如果希望阻止这一默认行为，可以在标签上添加 `@submit.native.prevent`。

> [vue 键盘回车事件导致页面刷新的问题，路由多了一个问号 | cnblogs](https://www.cnblogs.com/hibiscus-ben/p/10861062.html)

解决方案二：为表单元素增加属性 `onSubmit="return false"`。

> [Vue element-ui 键盘回车事件表单自动提交造成页面刷新问题](https://weiku.co/article/297/)

## .sync 修饰符

[.sync 修饰符 | vue](https://cn.vuejs.org/v2/guide/components-custom-events.html#sync-%E4%BF%AE%E9%A5%B0%E7%AC%A6)

```html
<history-dialog
  :historys="historyTable"
  :dialogVisible.sync="dialogHistoryTableVisible"
/>
```

```js
methods: {
   onClose() {
      this.$emit("update:dialogVisible", false);
   },
},
```

## 优化图片加载失败

```html
<div>
  <img :src="item.picture" @error.once="handleImgError($event)" />
</div>
```

```javascript
handleImgError (e) {
  e.currentTarget.src = "http://www.ianbiangou.cn/index/ICON2.png"
}
```

## References

- [jQuery.isEmptyObject() 函数详解 | csdn](https://blog.csdn.net/wangqing84411433/article/details/79582888)
- [简单理解 Vue 中的 nextTick | juejin](https://juejin.im/post/5a6fdb846fb9a01cc0268618)
- [Vue 中键盘监听事件（解决 element 监听键盘不生效）| jianshu](https://www.jianshu.com/p/f2172afaf9bf)
- [图片加载失败优化处理 | cnblogs](https://www.cnblogs.com/zhuzhenwei918/p/6891368.html)
- [How to disable webpack dev server auto reload? | stackoverflow](https://stackoverflow.com/questions/41797704/how-to-disable-webpack-dev-server-auto-reload)
