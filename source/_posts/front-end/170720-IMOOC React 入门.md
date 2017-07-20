---
title: IMOOC React 入门
permalink: imooc-react-getting-started-tutorial
date: 2017-07-20 19:00:00
comments: true
toc: true
tags:
   - react
description:
---

## React 介绍
### 初识 React
1. React 不是一个完整的 MVC、MVVM 框架，其只负责 View 层，MVC 已经不适用于某些场景的开发
2. React 跟 Web Components 不冲突
3. React 的特点就是“轻”，数据单向绑定，独立、小巧、快速、创新
4. 组件化的开发思路，小组件构成大组件，高度可重用

### React 应用场景
1. 复杂场景下的高性能
2. 重用组件库，组件组合
3. “懒”，少做无用功

> 你总是这样轻言放弃的话，无论过多久都只会原地踏步。 -- 多啦a梦

### 前置知识
1. JS CSS
2. Sass Compass
3. Yeoman Grunt Webpack
4. CommonJS NodeJS
5. Git GitHub

### To Be A Better Engineer
1. 无论知识有多新、项目有多难，只要来了什么姿势都要上
2. 没人疼、没人爱，团队中没人可以帮上忙，要学会借助外力，视频、Google、开源项目
3. 积极要求进步

## React 的 JSX 与 Style
官网：[React - A JavaScript library for building user interfaces](https://facebook.github.io/react/)

> 罐头是1810发明出来的，可是开罐器呢，却在1858年才发明出来。有时就是这样，重要的东西可能迟来一步，但却一定会到。生活和爱情，都是如此。程序，当然也不例外。

<!-- more -->

``` html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Hello World</title>
    <script src="https://unpkg.com/react@latest/dist/react.js"></script>
    <script src="https://unpkg.com/react-dom@latest/dist/react-dom.js"></script>
    <script src="https://unpkg.com/babel-standalone@6.15.0/babel.min.js"></script>
    <style>
        .fontcolor {
            color: blue !important;
        }
    </style>
</head>
<body>
    <div id="root"></div>
    <script type="text/babel">
        var Hello = React.createClass({
            render: function(){
                return <div className="fontcolor">Hello {this.props.name}!</div>;
            }
        });

        class Welcome extends React.Component {
            render() {
                return <h1>Hello, {this.props.name}</h1>;
            }
        }

        ReactDOM.render(
            <div>
                <Hello name="World"></Hello>
                <Welcome name="World"></Welcome>
            </div>,
            document.getElementById('root')
        );
    </script>
</body>
</html>
```
添加组件属性，有一个地方需要注意：class 属性需要写成 className ，for 属性需要写成 htmlFor ，这是因为 class 和 for 是 JavaScript 的保留字。然后，属性名都是驼峰命名法。

> 正所谓粉末登场，远近起帆，风云更迭，嬉皮而黄，多少聚散于圆缺。

## React 组件的生命周期和事件处理
### React Components Lifecycle
[State and Lifecycle - React](https://facebook.github.io/react/docs/state-and-lifecycle.html)

1. Mounted
React Component 被 render 解析生成对应的 DOM 节点，并在插入浏览器的 DOM 结构的一个过程
2. Update
一个 mounted 的 React Component 被重新 render 的过程（只有影响了DOM结构时才会被改变）
3. Unmounted
一个 mounted 的 React Component 对应的 DOM 节点被从 DOM 结构中移除的过程

每一个状态都封装了对应的 hook 函数。`will` and `did` hook

###  React Event Listener
[Handling Events - React](https://facebook.github.io/react/docs/handling-events.html)

``` javascript
class ClickBtn extends React.Component {
     handleClick(e) {
         e.preventDefault();
         console.log('The link was clicked.');
     }

     render() {
         return (
             <a href="#" onClick={this.handleClick}>Click me</a>
         );
     }
 }

ReactDOM.render(
    <div>
        <Hello name="World"></Hello>
        <Welcome name="World"></Welcome>
        <ClickBtn />
    </div>,
    document.getElementById('root')
);
```

官方文档值得反复看。

> Reference:
> - [React入门课程介绍-慕课网](http://www.imooc.com/video/10427)
