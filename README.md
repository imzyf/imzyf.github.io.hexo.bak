# ZYF.IM 源文件

## 初始化环境

```bash
npm install hexo-cli -g
yarn add
mkdir public && cd public
git init .
git remote add origin ubuntu@zyf.im:/home/ubuntu/imzyf/blog
```

## Tips

按 `t` 进入搜索模式。

## Hexo command

```bash
# generate
hexo g

# server
hexo s
```

## 博文

- [所有文章原始 Markdown 文件](source/_posts)

## theme even 本地化

1. `_config.yml` 的修改。
2. 移除 `source` 中的 `favicon.ico` `robots.txt`
3. 修改 `source/image/reward` 打赏图片。
4. 修改 `layout/_partial/footer.swig` 添加 `statcounter` 统计代码。

`layout/_partial/head.swig` 添加： 

```
<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<script>
  (adsbygoogle = window.adsbygoogle || []).push({
    google_ad_client: "ca-pub-2330747317815601",
    enable_page_level_ads: true
  });
</script>
```
