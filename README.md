# ZYF.IM 源文件

## 初始化环境

```bash
yarn install hexo-cli -g
yarn
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

1、`_config.yml` 的修改。
2、移除 `source` 中的 `favicon.ico` `robots.txt`

### StatCounter

`layout/_partial/footer.swig`

```html
<!-- Start of StatCounter Code for Default Guide -->
<script type="text/javascript">
  var sc_project = 11262529;
  var sc_invisible = 1;
  var sc_security = "476b93ef";
  var scJsHost =
    "https:" == document.location.protocol ? "https://secure." : "http://www.";
  document.write(
    "<sc" +
      "ript type='text/javascript' src='" +
      scJsHost +
      "statcounter.com/counter/counter.js'></" +
      "script>"
  );
</script>
<noscript
  ><div class="statcounter">
    <a title="web analytics" href="http://statcounter.com/" target="_blank"
      ><img
        class="statcounter"
        src="//c.statcounter.com/11262529/0/476b93ef/1/"
        alt="web
analytics"
    /></a></div
></noscript>
<!-- End of StatCounter Code for Default Guide -->
```

### Google AD

`layout/_partial/head.swig`

```
<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<!-- YifanBlog -->
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-2330747317815601"
     data-ad-slot="7589254134"
     data-ad-format="auto"
     data-full-width-responsive="true"></ins>
<script>
(adsbygoogle = window.adsbygoogle || []).push({});
</script>
```

### 添加 Vien link

`layout/_partial/footer.swig`

```html
<span class="power-by">
  {{ __('footer.powered', '<a
    class="hexo-link"
    rel="nofollow"
    href="https://hexo.io/"
    >Hexo</a
  >') }}
</span>
<span class="division">|</span>
<span class="theme-info">
  {{ __('footer.theme') }} -
  <a
    class="theme-link"
    rel="nofollow"
    href="https://github.com/ahonn/hexo-theme-even"
    >Even</a
  >
</span>

{% if is_home() %}
<span class="division">|</span>
<span
  ><a href="https://vien.tech/" target="_blank" rel="noopener"
    >Vien Blog</a
  ></span
>
{% endif %}
```

### Global width

`source/css/_variables.scss`

```scss
// Global width of '<body>'.
$global-body-width: 900px !default;
```
