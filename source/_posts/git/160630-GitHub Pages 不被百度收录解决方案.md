---
title: GitHub Pages 不被百度收录解决方案
permalink: github-pages-forbidden-baiduspide-solution
comments: true
date: 2016-06-30 20:00:00
tags:
  - github
  - git
  - hexo
---
在 [使用 Hexo 和 Github 搭建个人独立博客](/2016/06/24/hexo-github-blog/) 几天后，发现百度并不对博客进行收录。

在天朝使用百度搜索毕竟多数，使用百度站长工具-抓取诊断，在百度Spider抓取结果返回HTTP头：HTTP/1.1 403 Forbidden，原来是 GitHub 禁止了百度爬虫的爬去。

Google 后早已有许多热心网友给出了解决方案，自己在这里总结下。

## 思路一：利用 CDN 解决百度爬虫被 Github Pages 拒绝的问题
### 解决思路
既然 Github 彻底和百度决裂了，那我们也只能自己动手来解决了。Github 可能是封了百度的 IP，也有可能是封了百度爬虫的 User-Agent。

所以要解决这个问题，最好就不要让百度爬虫直接访问 Github 了，需要在中间套一层 [反向代理](https://zh.wikipedia.org/wiki/%E5%8F%8D%E5%90%91%E4%BB%A3%E7%90%86)。

那么问题又来了，既然我可以搭一个反向代理服务器了，那我为什么不直接把博客放在这台服务器上？放 Github Pages 上不就是为了少一台服务器，少一点费用吗？

那有没有免费的第三方反向代理服务呢？当然有，其实现在各种 **CDN 服务** 不就是吗？而且还额外提供了各种网络环境下的加速功能。
但是使用 CDN 也会有一个非常大的缺点：只能对 **静态资源** 做，因为 CDN 和反向代理有一个很大的不同就是：它会做缓存，并向各个节点分发。
所以 CDN 一般都是用来给静态资源做加速的。如果你对动态页面做加速，用户看到的页面在一段时间内就一直不会变了。但是我们不怕！因为 Github Pages 本来就是全静态的！

国内提供 CDN 服务的有：加速乐、七牛云存储、又拍云等
最后选择了 [**又拍云**](https://www.upyun.com/index.html)

CDN 回源配置
有设置缓存时间的功能，上面明确写了：CDN 缓存时间是指 UPYUN 回源取得文件后，文件在 UPYUN CDN 网络中的缓存的时间，超过缓存时间则重新回源获取文件。
是的，这才是真正满足我需求的功能！

这个解决方案我尝试了，但是在 CDN 域名配置时，有天朝特色要求域名必须备案，我的域名 `zyf.im` 是在 [name.com](http://www.name.com) 上注册的，`.im` 的尾缀也无法在国内备案。所以这个方案不适合我。

<!-- more -->

## 思路二：通过 Dnspod 的智能 DNS 服务
在这里博主首先分析了：使用 CDN 可能 **无法** 真正解决百度被拒绝的问题。理由是：**CDN 节点众多，百度爬取的节点可能并没有页面的缓存**。

通过 Dnspod 的智能 DNS 服务可以变相解决这个问题，大概的设置如下图所示，只要为你所有的主机记录重复添加 A 记录，把线路类型设置为百度，并将记录值指向你自己的云主机即可。

你说什么？等下！自己的云主机？没错，其实这种方式就是 **专门为百度的爬虫增开了一个小窗口**，使得它可以在你自己的服务器上爬取内容，而不是直接去爬取 Github Pages的内容。你需要自己搭个服务器，并将你的静态网站架在上面。

我博客解决方案就是采用这种方法。看起来有些“笨”因为我又搭建了一个 Server 用于博客，相当于没有完全利用 GitHub Pages，实际上普通用户访问我的博客就是有利用 GitHub 的 CDN 服务的，更快一些。而且我这么做还利用了 GitHub Webhook，当我把新的页面提交到 GitHub 时，我的博客服务器会自动 `pull` 最新的项目，这么看也就不那么“傻”了。

请参看：[GitHub Webhook 自动部署 Hexo](/2016/06/30/github-webhook-example/)

经过这么一配置，我的博客现在已经被百度收录了。百度搜索：`site:zyf.im`

**2017年04月22日 Updated**：
现在我的 Blog 使用的是 [UFOVPS](https://www.ufovps.com/) 直接部署的

> Reference:
> - [DOZER-利用 CDN 解决百度爬虫被 Github Pages 拒绝的问题](http://www.dozer.cc/2015/06/github-pages-and-cdn.html)
> - [jerryzou-解决 Github Pages 禁止百度爬虫的方法与可行性分析](http://jerryzou.com/posts/feasibility-of-allowing-baiduSpider-for-Github-Pages/)
